#!/usr/bin/env python3
"""
HTML Hero — original learning-media generator.

Every asset produced by this script is created from scratch by this repository's
own code. Nothing is downloaded, nothing is traced from or derived from a
third-party work, and no third-party asset is hotlinked. All output is released
under CC0-1.0 (public domain dedication) as recorded in
`src/content/media/manifest.ts` and surfaced on the in-app /media page.

Requires: pillow, imageio-ffmpeg  (see README "Media asset setup").
Run via: npm run media:generate
"""

from __future__ import annotations

import json
import math
import os
import random
import shutil
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont

try:
    import imageio_ffmpeg

    FFMPEG = imageio_ffmpeg.get_ffmpeg_exe()
except Exception:  # pragma: no cover - environment dependent
    FFMPEG = shutil.which("ffmpeg")

ROOT = Path(__file__).resolve().parent.parent
MEDIA = ROOT / "public" / "learning-media"

DIRS = {
    "images": MEDIA / "images",
    "svg": MEDIA / "svg",
    "icons": MEDIA / "icons",
    "video": MEDIA / "video",
    "audio": MEDIA / "audio",
    "posters": MEDIA / "posters",
    "captions": MEDIA / "captions",
}

# Responsive widths emitted for every raster scene.
WIDTHS = [480, 800, 1200, 1600]


# --------------------------------------------------------------------------
# Small drawing helpers
# --------------------------------------------------------------------------
def lerp(a: float, b: float, t: float) -> float:
    return a + (b - a) * t


def mix(c1: tuple[int, int, int], c2: tuple[int, int, int], t: float) -> tuple[int, int, int]:
    return (
        int(lerp(c1[0], c2[0], t)),
        int(lerp(c1[1], c2[1], t)),
        int(lerp(c1[2], c2[2], t)),
    )


def vertical_gradient(size, top, bottom) -> Image.Image:
    w, h = size
    img = Image.new("RGB", (1, h))
    px = img.load()
    for y in range(h):
        px[0, y] = mix(top, bottom, y / max(h - 1, 1))
    return img.resize((w, h), Image.Resampling.BILINEAR)


def radial_glow(img: Image.Image, centre, radius: int, colour, strength: float = 0.6) -> None:
    """Additively blend a soft radial light onto `img`."""
    w, h = img.size
    glow = Image.new("RGB", (w, h), (0, 0, 0))
    d = ImageDraw.Draw(glow)
    cx, cy = centre
    steps = 26
    for i in range(steps, 0, -1):
        t = i / steps
        r = int(radius * t)
        c = tuple(int(v * (1 - t) * strength) for v in colour)
        d.ellipse((cx - r, cy - r, cx + r, cy + r), fill=c)
    glow = glow.filter(ImageFilter.GaussianBlur(radius * 0.18))
    base = img.load()
    gl = glow.load()
    for y in range(h):
        for x in range(w):
            br, bg, bb = base[x, y]
            gr, gg, gb = gl[x, y]
            base[x, y] = (min(255, br + gr), min(255, bg + gg), min(255, bb + gb))


def add_grain(img: Image.Image, amount: int = 6, seed: int = 7) -> None:
    """A little luminance noise stops the gradients looking synthetic."""
    rnd = random.Random(seed)
    px = img.load()
    w, h = img.size
    for y in range(h):
        for x in range(w):
            n = rnd.randint(-amount, amount)
            r, g, b = px[x, y]
            px[x, y] = (
                max(0, min(255, r + n)),
                max(0, min(255, g + n)),
                max(0, min(255, b + n)),
            )


def load_font(size: int, bold: bool = False) -> ImageFont.FreeTypeFont:
    candidates = [
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf" if bold else "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
        "/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf" if bold else "/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf",
    ]
    for c in candidates:
        if Path(c).exists():
            try:
                return ImageFont.truetype(c, size)
            except OSError:
                continue
    return ImageFont.load_default(size)


# --------------------------------------------------------------------------
# Scene painters — each returns a finished RGB image at master resolution
# --------------------------------------------------------------------------
MASTER = (1600, 1067)  # 3:2 landscape master
PORTRAIT = (1600, 2400)
SQUARE = (1600, 1600)


def scene_coast_sunrise(size=MASTER) -> Image.Image:
    w, h = size
    img = vertical_gradient(size, (28, 42, 88), (238, 148, 96))
    d = ImageDraw.Draw(img)
    horizon = int(h * 0.62)

    radial_glow(img, (int(w * 0.68), int(horizon * 0.86)), int(w * 0.45), (255, 196, 120), 0.85)
    d = ImageDraw.Draw(img)

    # Distant headlands, layered back to front for aerial perspective.
    layers = [
        (0.52, (72, 88, 128), 0.30),
        (0.57, (54, 68, 104), 0.55),
        (0.61, (36, 46, 74), 0.85),
    ]
    rnd = random.Random(11)
    for base_y, colour, _ in layers:
        pts = [(0, h)]
        y0 = int(h * base_y)
        x = 0
        while x <= w:
            pts.append((x, y0 + int(math.sin(x / 210.0 + base_y * 9) * 34) + rnd.randint(-9, 9)))
            x += 40
        pts.append((w, h))
        d.polygon(pts, fill=colour)

    # Sea.
    sea = vertical_gradient((w, h - horizon), (196, 138, 122), (26, 38, 66))
    img.paste(sea, (0, horizon))
    d = ImageDraw.Draw(img)

    # Sun glitter path on the water.
    rnd = random.Random(3)
    for i in range(230):
        t = rnd.random()
        y = horizon + int((h - horizon) * (t**1.6)) + 2
        spread = 30 + t * w * 0.36
        x = int(w * 0.68 + rnd.gauss(0, spread))
        length = int(6 + t * 46)
        alpha = 1.0 - t * 0.75
        c = mix((26, 38, 66), (255, 214, 168), alpha)
        d.line([(x, y), (x + length, y)], fill=c, width=1 + int(t * 2))

    # Foreground rocks.
    for cx, cy, rw, rh in [(int(w * 0.12), int(h * 0.94), 260, 90), (int(w * 0.3), int(h * 1.0), 200, 70)]:
        d.ellipse((cx - rw, cy - rh, cx + rw, cy + rh), fill=(22, 26, 40))

    add_grain(img, 5, 21)
    return img


def scene_forest_path(size=MASTER) -> Image.Image:
    w, h = size
    img = vertical_gradient(size, (188, 214, 186), (34, 62, 44))
    d = ImageDraw.Draw(img)
    radial_glow(img, (int(w * 0.46), int(h * 0.12)), int(w * 0.5), (206, 232, 170), 0.7)
    d = ImageDraw.Draw(img)

    rnd = random.Random(29)
    # Tree trunks receding in depth.
    for depth in range(5, 0, -1):
        t = depth / 5.0
        colour = mix((44, 74, 52), (16, 30, 22), 1 - t)
        count = 6 + depth * 2
        for i in range(count):
            x = rnd.randint(-40, w + 40)
            width = int(lerp(64, 10, t))
            top = int(h * lerp(0.02, 0.3, t))
            d.rectangle((x, top, x + width, h), fill=colour)

    # The path itself.
    path = [
        (int(w * 0.42), int(h * 0.42)),
        (int(w * 0.5), int(h * 0.42)),
        (int(w * 0.86), h),
        (int(w * 0.16), h),
    ]
    d.polygon(path, fill=(150, 128, 96))
    d.polygon(
        [
            (int(w * 0.44), int(h * 0.44)),
            (int(w * 0.49), int(h * 0.44)),
            (int(w * 0.76), h),
            (int(w * 0.28), h),
        ],
        fill=(168, 146, 112),
    )

    # Canopy light shafts.
    overlay = Image.new("RGB", (w, h), (0, 0, 0))
    od = ImageDraw.Draw(overlay)
    for i in range(7):
        x0 = int(w * (0.2 + i * 0.1))
        od.polygon([(x0, 0), (x0 + 70, 0), (x0 + 240, h), (x0 + 110, h)], fill=(46, 52, 30))
    overlay = overlay.filter(ImageFilter.GaussianBlur(38))
    base, ov = img.load(), overlay.load()
    for y in range(h):
        for x in range(w):
            br, bg, bb = base[x, y]
            orr, og, ob = ov[x, y]
            base[x, y] = (min(255, br + orr), min(255, bg + og), min(255, bb + ob))

    add_grain(img, 5, 44)
    return img


def scene_city_dusk(size=MASTER) -> Image.Image:
    w, h = size
    img = vertical_gradient(size, (22, 26, 54), (120, 78, 108))
    d = ImageDraw.Draw(img)
    radial_glow(img, (int(w * 0.22), int(h * 0.66)), int(w * 0.4), (238, 150, 110), 0.7)
    d = ImageDraw.Draw(img)

    rnd = random.Random(97)
    skyline_base = int(h * 0.82)
    for layer, (colour, spread) in enumerate([((48, 46, 82), 0.30), ((30, 30, 58), 0.44), ((16, 16, 36), 0.58)]):
        x = -30
        while x < w + 30:
            bw = rnd.randint(60, 150)
            bh = int(h * spread * rnd.uniform(0.55, 1.0))
            top = skyline_base - bh
            d.rectangle((x, top, x + bw, h), fill=colour)
            if layer == 2:
                for wy in range(top + 18, h - 20, 26):
                    for wx in range(x + 12, x + bw - 12, 22):
                        if rnd.random() < 0.42:
                            c = (255, 214, 140) if rnd.random() < 0.75 else (168, 214, 255)
                            d.rectangle((wx, wy, wx + 8, wy + 12), fill=c)
            x += bw + rnd.randint(6, 26)

    add_grain(img, 5, 63)
    return img


def scene_studio_desk(size=MASTER) -> Image.Image:
    """A calm workspace scene — used for 'about'/business style examples."""
    w, h = size
    img = vertical_gradient(size, (238, 234, 228), (208, 198, 188))
    d = ImageDraw.Draw(img)
    radial_glow(img, (int(w * 0.78), int(h * 0.12)), int(w * 0.5), (255, 246, 220), 0.5)
    d = ImageDraw.Draw(img)

    desk_y = int(h * 0.58)
    d.rectangle((0, desk_y, w, h), fill=(166, 122, 82))
    d.rectangle((0, desk_y, w, desk_y + 14), fill=(190, 146, 100))

    # Laptop.
    lx, ly = int(w * 0.3), desk_y
    d.polygon([(lx, ly), (lx + 430, ly), (lx + 470, ly + 26), (lx - 40, ly + 26)], fill=(206, 208, 212))
    d.rectangle((lx + 30, ly - 300, lx + 400, ly), fill=(38, 40, 48))
    d.rectangle((lx + 44, ly - 286, lx + 386, ly - 14), fill=(58, 92, 148))
    for i, wdt in enumerate([220, 180, 260, 140, 200]):
        d.rectangle((lx + 62, ly - 262 + i * 34, lx + 62 + wdt, ly - 250 + i * 34), fill=(140, 178, 226))

    # Mug + notebook + plant.
    d.ellipse((int(w * 0.66), desk_y - 80, int(w * 0.66) + 110, desk_y + 14), fill=(232, 232, 236))
    d.ellipse((int(w * 0.66) + 16, desk_y - 74, int(w * 0.66) + 94, desk_y - 44), fill=(96, 62, 40))
    d.rectangle((int(w * 0.12), desk_y - 26, int(w * 0.12) + 240, desk_y + 10), fill=(226, 220, 208))
    d.rectangle((int(w * 0.12), desk_y - 26, int(w * 0.12) + 240, desk_y - 16), fill=(198, 88, 74))

    px, py = int(w * 0.85), desk_y
    d.rectangle((px, py - 90, px + 96, py + 6), fill=(178, 122, 96))
    rnd = random.Random(5)
    for i in range(14):
        ex = px + 48 + rnd.randint(-70, 70)
        ey = py - 100 - rnd.randint(0, 130)
        d.ellipse((ex - 34, ey - 22, ex + 34, ey + 22), fill=(62, 118, 78))

    add_grain(img, 4, 12)
    return img


def scene_portrait(size=PORTRAIT) -> Image.Image:
    """A stylised portrait silhouette — the 'team member' example image."""
    w, h = size
    img = vertical_gradient(size, (86, 118, 156), (36, 54, 86))
    radial_glow(img, (int(w * 0.5), int(h * 0.3)), int(w * 0.8), (140, 176, 214), 0.5)
    d = ImageDraw.Draw(img)

    cx = w // 2
    # Shoulders.
    d.ellipse((cx - int(w * 0.62), int(h * 0.72), cx + int(w * 0.62), int(h * 1.5)), fill=(232, 226, 216))
    d.ellipse((cx - int(w * 0.56), int(h * 0.76), cx + int(w * 0.56), int(h * 1.5)), fill=(58, 74, 108))
    # Neck + head.
    d.rectangle((cx - 70, int(h * 0.55), cx + 70, int(h * 0.8)), fill=(214, 176, 148))
    d.ellipse((cx - 150, int(h * 0.26), cx + 150, int(h * 0.62)), fill=(224, 186, 156))
    # Hair.
    d.ellipse((cx - 164, int(h * 0.22), cx + 164, int(h * 0.5)), fill=(58, 42, 38))
    d.rectangle((cx - 164, int(h * 0.34), cx - 120, int(h * 0.52)), fill=(58, 42, 38))
    d.rectangle((cx + 120, int(h * 0.34), cx + 164, int(h * 0.52)), fill=(58, 42, 38))

    add_grain(img, 4, 88)
    return img


def scene_product(size=SQUARE) -> Image.Image:
    """A clean product-shot style image: a ceramic bottle on a seamless backdrop."""
    w, h = size
    img = vertical_gradient(size, (246, 243, 238), (216, 210, 200))
    d = ImageDraw.Draw(img)
    # Backdrop sweep + contact shadow.
    d.ellipse((int(w * 0.1), int(h * 0.72), int(w * 0.9), int(h * 0.88)), fill=(196, 190, 180))
    shadow = Image.new("RGB", (w, h), (0, 0, 0))
    sd = ImageDraw.Draw(shadow)
    sd.ellipse((int(w * 0.26), int(h * 0.74), int(w * 0.74), int(h * 0.84)), fill=(64, 60, 56))
    shadow = shadow.filter(ImageFilter.GaussianBlur(26))
    img = Image.blend(img, Image.composite(shadow, img, shadow.convert("L")), 0.35)
    d = ImageDraw.Draw(img)

    bx, bw = w // 2, int(w * 0.2)
    top, bottom = int(h * 0.24), int(h * 0.8)
    d.rounded_rectangle((bx - bw, top + 90, bx + bw, bottom), radius=54, fill=(64, 110, 104))
    d.rounded_rectangle((bx - 46, top, bx + 46, top + 120), radius=22, fill=(52, 92, 88))
    d.rounded_rectangle((bx - 56, top - 26, bx + 56, top + 16), radius=16, fill=(206, 176, 122))
    # Specular highlight + label.
    d.rounded_rectangle((bx - bw + 26, top + 130, bx - bw + 58, bottom - 80), radius=16, fill=(112, 158, 150))
    d.rounded_rectangle((bx - bw + 18, int(h * 0.5), bx + bw - 18, int(h * 0.68)), radius=10, fill=(240, 236, 228))
    f = load_font(46, bold=True)
    d.text((bx, int(h * 0.57)), "HERO", font=f, fill=(64, 110, 104), anchor="mm")

    add_grain(img, 3, 55)
    return img


def scene_workshop(size=MASTER) -> Image.Image:
    """A service / workshop scene for the local-service project examples."""
    w, h = size
    img = vertical_gradient(size, (66, 74, 92), (30, 34, 46))
    d = ImageDraw.Draw(img)
    radial_glow(img, (int(w * 0.5), int(h * 0.18)), int(w * 0.55), (255, 226, 168), 0.6)
    d = ImageDraw.Draw(img)

    floor = int(h * 0.72)
    d.rectangle((0, floor, w, h), fill=(58, 58, 62))
    for x in range(0, w, 160):
        d.line([(x, floor), (x - 120, h)], fill=(70, 70, 76), width=3)

    # Pegboard wall with hanging tools.
    d.rectangle((int(w * 0.08), int(h * 0.18), int(w * 0.62), floor - 40), fill=(96, 84, 68))
    rnd = random.Random(17)
    for i in range(9):
        tx = int(w * 0.12) + i * int(w * 0.056)
        ty = int(h * 0.24)
        length = rnd.randint(90, 200)
        d.rectangle((tx, ty, tx + 14, ty + length), fill=(186, 190, 196))
        d.rectangle((tx - 8, ty + length, tx + 22, ty + length + 34), fill=(198, 92, 66))

    # Workbench.
    d.rectangle((int(w * 0.66), int(h * 0.56), w, floor + 20), fill=(122, 96, 66))
    d.rectangle((int(w * 0.66), int(h * 0.56), w, int(h * 0.6)), fill=(150, 120, 84))

    add_grain(img, 5, 71)
    return img


def scene_plate(size=MASTER) -> Image.Image:
    """A top-down dish, used by the restaurant project examples."""
    w, h = size
    img = vertical_gradient(size, (52, 40, 34), (28, 22, 20))
    d = ImageDraw.Draw(img)
    radial_glow(img, (int(w * 0.5), int(h * 0.42)), int(w * 0.5), (188, 150, 110), 0.55)
    d = ImageDraw.Draw(img)

    cx, cy, r = w // 2, int(h * 0.5), int(h * 0.4)
    d.ellipse((cx - r - 16, cy - r - 16, cx + r + 16, cy + r + 16), fill=(20, 16, 14))
    d.ellipse((cx - r, cy - r, cx + r, cy + r), fill=(240, 238, 232))
    d.ellipse((cx - int(r * 0.78), cy - int(r * 0.78), cx + int(r * 0.78), cy + int(r * 0.78)), fill=(228, 224, 216))

    rnd = random.Random(41)
    palette = [(176, 72, 54), (88, 128, 62), (218, 176, 88), (140, 92, 60), (232, 226, 208)]
    for i in range(90):
        a = rnd.uniform(0, math.tau)
        rad = rnd.uniform(0, r * 0.62)
        x, y = cx + math.cos(a) * rad, cy + math.sin(a) * rad
        s = rnd.randint(12, 42)
        d.ellipse((x - s, y - s * 0.7, x + s, y + s * 0.7), fill=palette[rnd.randrange(len(palette))])

    add_grain(img, 4, 33)
    return img


def scene_event(size=MASTER) -> Image.Image:
    """A stage / audience scene for the event project examples."""
    w, h = size
    img = vertical_gradient(size, (18, 14, 34), (58, 26, 74))
    d = ImageDraw.Draw(img)
    for i, x in enumerate([0.22, 0.5, 0.78]):
        radial_glow(img, (int(w * x), int(h * 0.1)), int(w * 0.34), [(255, 120, 160), (140, 180, 255), (255, 196, 120)][i], 0.6)
    d = ImageDraw.Draw(img)

    stage = int(h * 0.66)
    d.rectangle((int(w * 0.14), stage, int(w * 0.86), int(h * 0.78)), fill=(28, 20, 40))
    rnd = random.Random(23)
    for i in range(70):
        x = rnd.randint(0, w)
        head = int(h * rnd.uniform(0.8, 0.94))
        s = rnd.randint(14, 30)
        d.ellipse((x - s, head - s, x + s, head + s), fill=(12, 10, 20))
        d.ellipse((x - s * 2, head + s, x + s * 2, h), fill=(12, 10, 20))

    add_grain(img, 5, 91)
    return img


def scene_vehicle(size=MASTER) -> Image.Image:
    """A stylised vehicle profile for the vehicle-rental project examples."""
    w, h = size
    img = vertical_gradient(size, (152, 190, 224), (232, 226, 210))
    d = ImageDraw.Draw(img)
    road = int(h * 0.74)
    d.rectangle((0, road, w, h), fill=(74, 76, 80))
    d.rectangle((0, road, w, road + 10), fill=(198, 198, 196))
    for x in range(0, w, 220):
        d.rectangle((x, int(h * 0.88), x + 120, int(h * 0.9)), fill=(232, 226, 190))

    bx, by = int(w * 0.5), road
    body = (76, 108, 176)
    d.rounded_rectangle((bx - 460, by - 150, bx + 460, by - 30), radius=48, fill=body)
    d.polygon(
        [(bx - 240, by - 150), (bx - 130, by - 268), (bx + 190, by - 268), (bx + 290, by - 150)],
        fill=(96, 128, 196),
    )
    d.polygon([(bx - 200, by - 158), (bx - 110, by - 250), (bx + 10, by - 250), (bx + 10, by - 158)], fill=(198, 224, 240))
    d.polygon([(bx + 36, by - 158), (bx + 36, by - 250), (bx + 172, by - 250), (bx + 254, by - 158)], fill=(198, 224, 240))
    for wx in (bx - 280, bx + 280):
        d.ellipse((wx - 92, by - 92, wx + 92, by + 92), fill=(28, 28, 32))
        d.ellipse((wx - 40, by - 40, wx + 40, by + 40), fill=(178, 180, 186))
    d.ellipse((bx + 420, by - 120, bx + 470, by - 78), fill=(255, 236, 168))

    add_grain(img, 4, 66)
    return img


def scene_news(size=MASTER) -> Image.Image:
    """An abstract 'newsroom' composition for magazine-style examples."""
    w, h = size
    img = vertical_gradient(size, (240, 238, 232), (206, 202, 194))
    d = ImageDraw.Draw(img)
    rnd = random.Random(13)
    for i in range(9):
        x = rnd.randint(-100, w - 200)
        y = rnd.randint(-60, h - 200)
        cw, ch = rnd.randint(240, 520), rnd.randint(280, 520)
        rot = rnd.uniform(-9, 9)
        card = Image.new("RGB", (cw, ch), (252, 251, 248))
        cd = ImageDraw.Draw(card)
        cd.rectangle((0, 0, cw, 10), fill=(178, 62, 54))
        cd.rectangle((24, 40, cw - 24, 40 + int(ch * 0.32)), fill=(210, 206, 198))
        yy = 60 + int(ch * 0.32)
        while yy < ch - 24:
            cd.rectangle((24, yy, cw - rnd.randint(30, 140), yy + 9), fill=(168, 164, 158))
            yy += 22
        card = card.rotate(rot, expand=True, fillcolor=(240, 238, 232))
        img.paste(card, (x, y))
    add_grain(img, 4, 100)
    return img


SCENES: dict[str, tuple] = {
    "coast-sunrise": (scene_coast_sunrise, MASTER, "landscape"),
    "forest-path": (scene_forest_path, MASTER, "landscape"),
    "city-dusk": (scene_city_dusk, MASTER, "landscape"),
    "studio-desk": (scene_studio_desk, MASTER, "landscape"),
    "team-portrait": (scene_portrait, PORTRAIT, "portrait"),
    "product-bottle": (scene_product, SQUARE, "square"),
    "workshop-tools": (scene_workshop, MASTER, "landscape"),
    "restaurant-plate": (scene_plate, MASTER, "landscape"),
    "event-stage": (scene_event, MASTER, "landscape"),
    "vehicle-hire": (scene_vehicle, MASTER, "landscape"),
    "newsroom-desk": (scene_news, MASTER, "landscape"),
}


def build_rasters() -> list[dict]:
    records: list[dict] = []
    for slug, (fn, size, orientation) in SCENES.items():
        print(f"  scene: {slug}")
        master = fn(size)
        mw, mh = master.size
        variants = []
        for target in WIDTHS:
            if target > mw:
                continue
            th = round(mh * target / mw)
            v = master.resize((target, th), Image.Resampling.LANCZOS)
            jpg = DIRS["images"] / f"{slug}-{target}.jpg"
            v.save(jpg, "JPEG", quality=82, optimize=True, progressive=True)
            webp = DIRS["images"] / f"{slug}-{target}.webp"
            v.save(webp, "WEBP", quality=80, method=5)
            variants.append({"width": target, "height": th})
        # The default `src` fallback every lesson can rely on.
        default = master.resize((1200, round(mh * 1200 / mw)), Image.Resampling.LANCZOS)
        default.save(DIRS["images"] / f"{slug}.jpg", "JPEG", quality=84, optimize=True, progressive=True)
        records.append(
            {
                "slug": slug,
                "orientation": orientation,
                "widths": [v["width"] for v in variants],
                "defaultWidth": 1200,
                "defaultHeight": round(mh * 1200 / mw),
            }
        )
    return records


# --------------------------------------------------------------------------
# SVG illustrations and icons (hand-authored markup, written verbatim)
# --------------------------------------------------------------------------
SVGS: dict[str, str] = {
    "document-tree": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 420" role="img" aria-label="A diagram of an HTML document drawn as a tree, with html at the top branching into head and body.">
  <title>HTML document tree</title>
  <rect width="640" height="420" fill="#f6f7fb"/>
  <g fill="none" stroke="#94a3b8" stroke-width="3">
    <path d="M320 84 V126 M320 126 H180 V166 M320 126 H460 V166"/>
    <path d="M180 214 V250 M180 250 H110 V286 M180 250 H250 V286"/>
    <path d="M460 214 V250 M460 250 H392 V286 M460 250 H530 V286"/>
  </g>
  <g font-family="ui-monospace, SFMono-Regular, Menlo, monospace" font-size="20" text-anchor="middle">
    <rect x="248" y="44" width="144" height="46" rx="10" fill="#1e293b"/><text x="320" y="74" fill="#f8fafc">&lt;html&gt;</text>
    <rect x="112" y="166" width="136" height="46" rx="10" fill="#2563eb"/><text x="180" y="196" fill="#ffffff">&lt;head&gt;</text>
    <rect x="392" y="166" width="136" height="46" rx="10" fill="#0f766e"/><text x="460" y="196" fill="#ffffff">&lt;body&gt;</text>
    <rect x="46" y="286" width="128" height="42" rx="9" fill="#dbeafe" stroke="#2563eb"/><text x="110" y="314" fill="#1e3a8a" font-size="17">&lt;title&gt;</text>
    <rect x="188" y="286" width="128" height="42" rx="9" fill="#dbeafe" stroke="#2563eb"/><text x="252" y="314" fill="#1e3a8a" font-size="17">&lt;meta&gt;</text>
    <rect x="328" y="286" width="128" height="42" rx="9" fill="#ccfbf1" stroke="#0f766e"/><text x="392" y="314" fill="#134e4a" font-size="17">&lt;h1&gt;</text>
    <rect x="466" y="286" width="128" height="42" rx="9" fill="#ccfbf1" stroke="#0f766e"/><text x="530" y="314" fill="#134e4a" font-size="17">&lt;p&gt;</text>
  </g>
  <text x="320" y="384" text-anchor="middle" font-family="system-ui, sans-serif" font-size="16" fill="#475569">Every page is a tree: one root, two branches, many leaves.</text>
</svg>""",
    "anatomy-of-an-element": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 300" role="img" aria-label="A labelled diagram of an HTML element showing the opening tag, attribute, content and closing tag.">
  <title>Anatomy of an HTML element</title>
  <rect width="720" height="300" fill="#0f172a"/>
  <g font-family="ui-monospace, SFMono-Regular, Menlo, monospace" font-size="34">
    <text x="46" y="150" fill="#38bdf8">&lt;a</text>
    <text x="96" y="150" fill="#fbbf24"> href="about.html"</text>
    <text x="392" y="150" fill="#38bdf8">&gt;</text>
    <text x="412" y="150" fill="#e2e8f0">About us</text>
    <text x="572" y="150" fill="#38bdf8">&lt;/a&gt;</text>
  </g>
  <g stroke="#64748b" stroke-width="2" fill="none">
    <path d="M62 166 V206 H120"/><path d="M240 166 V228"/><path d="M470 166 V206 H430"/><path d="M606 166 V228"/>
  </g>
  <g font-family="system-ui, sans-serif" font-size="15" fill="#cbd5e1">
    <text x="126" y="212">opening tag</text>
    <text x="176" y="250">attribute (name="value")</text>
    <text x="252" y="212" text-anchor="end">content</text>
    <text x="546" y="250" text-anchor="middle">closing tag</text>
  </g>
</svg>""",
    "how-the-web-works": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 260" role="img" aria-label="A diagram showing a browser requesting a page from a server and the server sending HTML back.">
  <title>How a web page reaches your screen</title>
  <rect width="720" height="260" fill="#f8fafc"/>
  <g font-family="system-ui, sans-serif">
    <rect x="40" y="70" width="180" height="120" rx="14" fill="#ffffff" stroke="#cbd5e1" stroke-width="2"/>
    <rect x="40" y="70" width="180" height="28" rx="14" fill="#e2e8f0"/>
    <circle cx="60" cy="84" r="5" fill="#f87171"/><circle cx="78" cy="84" r="5" fill="#fbbf24"/><circle cx="96" cy="84" r="5" fill="#34d399"/>
    <text x="130" y="145" text-anchor="middle" font-size="17" fill="#0f172a">Your browser</text>
    <rect x="500" y="70" width="180" height="120" rx="14" fill="#1e293b"/>
    <g fill="#475569"><rect x="520" y="90" width="140" height="22" rx="5"/><rect x="520" y="120" width="140" height="22" rx="5"/><rect x="520" y="150" width="140" height="22" rx="5"/></g>
    <circle cx="536" cy="101" r="4" fill="#34d399"/><circle cx="536" cy="131" r="4" fill="#34d399"/><circle cx="536" cy="161" r="4" fill="#34d399"/>
    <text x="590" y="216" text-anchor="middle" font-size="17" fill="#0f172a">A web server</text>
    <path d="M232 108 H488" stroke="#2563eb" stroke-width="3" marker-end="url(#ah)"/>
    <path d="M488 156 H232" stroke="#0f766e" stroke-width="3" marker-end="url(#ah2)"/>
    <text x="360" y="98" text-anchor="middle" font-size="15" fill="#2563eb">1. "Please send me this page"</text>
    <text x="360" y="182" text-anchor="middle" font-size="15" fill="#0f766e">2. Here is the HTML file</text>
    <text x="130" y="216" text-anchor="middle" font-size="15" fill="#475569">3. The browser draws it</text>
  </g>
  <defs>
    <marker id="ah" markerWidth="9" markerHeight="9" refX="8" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 z" fill="#2563eb"/></marker>
    <marker id="ah2" markerWidth="9" markerHeight="9" refX="8" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 z" fill="#0f766e"/></marker>
  </defs>
</svg>""",
    "heading-hierarchy": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 320" role="img" aria-label="A diagram showing headings nested from h1 down to h3 like an indented outline.">
  <title>Heading hierarchy as an outline</title>
  <rect width="640" height="320" fill="#ffffff"/>
  <g font-family="system-ui, sans-serif">
    <rect x="30" y="30" width="580" height="52" rx="8" fill="#1d4ed8"/><text x="52" y="63" font-size="24" fill="#fff">h1 — the one page title</text>
    <rect x="70" y="96" width="540" height="44" rx="8" fill="#3b82f6"/><text x="92" y="125" font-size="20" fill="#fff">h2 — a major section</text>
    <rect x="110" y="152" width="500" height="38" rx="8" fill="#93c5fd"/><text x="132" y="178" font-size="17" fill="#0f172a">h3 — a part of that section</text>
    <rect x="110" y="200" width="500" height="38" rx="8" fill="#93c5fd"/><text x="132" y="226" font-size="17" fill="#0f172a">h3 — another part</text>
    <rect x="70" y="248" width="540" height="44" rx="8" fill="#3b82f6"/><text x="92" y="277" font-size="20" fill="#fff">h2 — the next major section</text>
  </g>
</svg>""",
    "semantic-landmarks": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 440" role="img" aria-label="A page layout diagram labelling the header, nav, main, article, aside and footer regions.">
  <title>Page landmarks</title>
  <rect width="640" height="440" fill="#f1f5f9"/>
  <g font-family="ui-monospace, Menlo, monospace" font-size="18" text-anchor="middle">
    <rect x="24" y="24" width="592" height="64" rx="10" fill="#312e81"/><text x="320" y="54" fill="#fff">&lt;header&gt;</text><text x="320" y="76" fill="#c7d2fe" font-size="13" font-family="system-ui">site name + logo</text>
    <rect x="24" y="98" width="592" height="48" rx="10" fill="#4338ca"/><text x="320" y="128" fill="#fff">&lt;nav&gt;</text>
    <rect x="24" y="156" width="404" height="212" rx="10" fill="#0f766e"/><text x="226" y="188" fill="#fff">&lt;main&gt;</text>
    <rect x="44" y="204" width="364" height="148" rx="8" fill="#14b8a6"/><text x="226" y="236" fill="#042f2e">&lt;article&gt;</text><text x="226" y="262" fill="#042f2e" font-size="13" font-family="system-ui">the page's own content</text>
    <rect x="438" y="156" width="178" height="212" rx="10" fill="#b45309"/><text x="527" y="188" fill="#fff">&lt;aside&gt;</text><text x="527" y="214" fill="#fde68a" font-size="13" font-family="system-ui">related, not essential</text>
    <rect x="24" y="378" width="592" height="42" rx="10" fill="#334155"/><text x="320" y="405" fill="#fff">&lt;footer&gt;</text>
  </g>
</svg>""",
    "responsive-images": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 300" role="img" aria-label="A diagram showing one image served at three different widths to phone, tablet and desktop screens.">
  <title>One image, several sizes</title>
  <rect width="720" height="300" fill="#0b1120"/>
  <g font-family="system-ui, sans-serif" fill="#e2e8f0">
    <rect x="40" y="90" width="80" height="140" rx="12" fill="#1e293b" stroke="#38bdf8" stroke-width="2"/>
    <rect x="48" y="104" width="64" height="46" rx="4" fill="#38bdf8"/><text x="80" y="252" font-size="14" text-anchor="middle">480w</text>
    <rect x="180" y="70" width="150" height="180" rx="12" fill="#1e293b" stroke="#818cf8" stroke-width="2"/>
    <rect x="192" y="84" width="126" height="76" rx="4" fill="#818cf8"/><text x="255" y="272" font-size="14" text-anchor="middle">800w</text>
    <rect x="390" y="60" width="290" height="190" rx="12" fill="#1e293b" stroke="#f472b6" stroke-width="2"/>
    <rect x="404" y="74" width="262" height="120" rx="4" fill="#f472b6"/><text x="535" y="272" font-size="14" text-anchor="middle">1600w</text>
    <text x="360" y="34" font-size="16" text-anchor="middle" fill="#94a3b8">srcset lets the browser choose the smallest file that still looks sharp</text>
  </g>
</svg>""",
    "form-anatomy": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 340" role="img" aria-label="A form diagram showing a label joined to its input by matching for and id values.">
  <title>A label and its input are joined by for and id</title>
  <rect width="640" height="340" fill="#ffffff"/>
  <g font-family="ui-monospace, Menlo, monospace" font-size="17">
    <text x="40" y="70" fill="#0f172a">&lt;label for=</text><text x="160" y="70" fill="#b45309">"email"</text><text x="228" y="70" fill="#0f172a">&gt;Email&lt;/label&gt;</text>
    <text x="40" y="150" fill="#0f172a">&lt;input id=</text><text x="150" y="150" fill="#b45309">"email"</text><text x="218" y="150" fill="#0f172a"> type="email"&gt;</text>
  </g>
  <path d="M190 82 C190 116 178 118 178 136" stroke="#b45309" stroke-width="2.5" fill="none" stroke-dasharray="5 4"/>
  <text x="300" y="112" font-family="system-ui, sans-serif" font-size="14" fill="#b45309">same value = they are connected</text>
  <g font-family="system-ui, sans-serif" font-size="15" fill="#334155">
    <rect x="40" y="196" width="560" height="112" rx="10" fill="#f8fafc" stroke="#cbd5e1"/>
    <text x="60" y="228">A screen reader now announces "Email, edit text".</text>
    <text x="60" y="256">Clicking the word "Email" puts the cursor in the box.</text>
    <text x="60" y="284">Without the pair, neither of those things happens.</text>
  </g>
</svg>""",
    "file-paths": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 360" role="img" aria-label="A folder tree showing index.html, an about folder and an images folder, with example relative paths.">
  <title>Relative paths in a project folder</title>
  <rect width="640" height="360" fill="#f8fafc"/>
  <g font-family="ui-monospace, Menlo, monospace" font-size="16" fill="#0f172a">
    <text x="34" y="46">my-site/</text>
    <text x="62" y="80">├── index.html</text>
    <text x="62" y="112">├── about.html</text>
    <text x="62" y="144">├── images/</text>
    <text x="96" y="176">│   └── logo.svg</text>
    <text x="62" y="208">└── projects/</text>
    <text x="96" y="240">    └── first.html</text>
  </g>
  <g font-family="system-ui, sans-serif" font-size="14" fill="#1e3a8a">
    <rect x="330" y="60" width="286" height="128" rx="10" fill="#eff6ff" stroke="#bfdbfe"/>
    <text x="348" y="88">From index.html:</text>
    <text x="348" y="114" font-family="ui-monospace, Menlo, monospace">images/logo.svg</text>
    <text x="348" y="144">From projects/first.html:</text>
    <text x="348" y="170" font-family="ui-monospace, Menlo, monospace">../images/logo.svg</text>
  </g>
  <text x="34" y="300" font-family="system-ui, sans-serif" font-size="14" fill="#475569">".." means "go up one folder". No leading slash means "start where I am".</text>
  <text x="34" y="326" font-family="system-ui, sans-serif" font-size="14" fill="#475569">Folder and file names: lowercase, hyphens, no spaces.</text>
</svg>""",
    "table-structure": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 320" role="img" aria-label="A table diagram showing caption, thead with th cells, tbody with td cells and tfoot.">
  <title>The parts of a data table</title>
  <rect width="640" height="320" fill="#ffffff"/>
  <text x="320" y="38" text-anchor="middle" font-family="system-ui, sans-serif" font-size="17" fill="#334155">&lt;caption&gt; Opening hours &lt;/caption&gt;</text>
  <g font-family="ui-monospace, Menlo, monospace" font-size="15">
    <rect x="40" y="56" width="560" height="52" fill="#1e293b"/>
    <text x="130" y="88" fill="#fff" text-anchor="middle">&lt;th scope="col"&gt;</text>
    <text x="320" y="88" fill="#fff" text-anchor="middle">&lt;th scope="col"&gt;</text>
    <text x="510" y="88" fill="#fff" text-anchor="middle">&lt;th scope="col"&gt;</text>
    <g fill="#f1f5f9" stroke="#cbd5e1">
      <rect x="40" y="108" width="180" height="46"/><rect x="220" y="108" width="190" height="46"/><rect x="410" y="108" width="190" height="46"/>
      <rect x="40" y="154" width="180" height="46"/><rect x="220" y="154" width="190" height="46"/><rect x="410" y="154" width="190" height="46"/>
    </g>
    <text x="130" y="137" text-anchor="middle" fill="#0f172a">&lt;th scope="row"&gt;</text>
    <text x="315" y="137" text-anchor="middle" fill="#334155">&lt;td&gt;</text><text x="505" y="137" text-anchor="middle" fill="#334155">&lt;td&gt;</text>
    <text x="130" y="183" text-anchor="middle" fill="#0f172a">&lt;th scope="row"&gt;</text>
    <text x="315" y="183" text-anchor="middle" fill="#334155">&lt;td&gt;</text><text x="505" y="183" text-anchor="middle" fill="#334155">&lt;td&gt;</text>
    <rect x="40" y="200" width="560" height="44" fill="#e2e8f0"/><text x="320" y="228" text-anchor="middle" fill="#0f172a">&lt;tfoot&gt; — totals or summary</text>
  </g>
  <g font-family="system-ui, sans-serif" font-size="14" fill="#64748b">
    <text x="40" y="278">scope="col" says "this heading describes the column below".</text>
    <text x="40" y="300">scope="row" says "this heading describes the row beside it".</text>
  </g>
</svg>""",
    "accessibility-tree": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 340" role="img" aria-label="A diagram showing how HTML becomes an accessibility tree that assistive technology reads.">
  <title>From HTML to the accessibility tree</title>
  <rect width="700" height="340" fill="#0f172a"/>
  <g font-family="system-ui, sans-serif">
    <rect x="30" y="60" width="190" height="220" rx="12" fill="#1e293b" stroke="#334155"/>
    <text x="125" y="90" text-anchor="middle" font-size="16" fill="#e2e8f0">Your HTML</text>
    <g font-family="ui-monospace, Menlo, monospace" font-size="13" fill="#38bdf8">
      <text x="48" y="126">&lt;nav&gt;</text><text x="48" y="150">&lt;h1&gt;</text><text x="48" y="174">&lt;button&gt;</text><text x="48" y="198">&lt;img alt="…"&gt;</text><text x="48" y="222">&lt;label&gt;</text>
    </g>
    <path d="M234 170 H286" stroke="#64748b" stroke-width="3" marker-end="url(#a1)"/>
    <rect x="296" y="60" width="200" height="220" rx="12" fill="#1e293b" stroke="#334155"/>
    <text x="396" y="90" text-anchor="middle" font-size="16" fill="#e2e8f0">Accessibility tree</text>
    <g font-size="13" fill="#a7f3d0">
      <text x="314" y="126">navigation</text><text x="314" y="150">heading, level 1</text><text x="314" y="174">button "Book"</text><text x="314" y="198">image "A red bike"</text><text x="314" y="222">textbox "Email"</text>
    </g>
    <path d="M510 170 H562" stroke="#64748b" stroke-width="3" marker-end="url(#a1)"/>
    <rect x="572" y="100" width="100" height="140" rx="12" fill="#134e4a" stroke="#14b8a6"/>
    <text x="622" y="160" text-anchor="middle" font-size="14" fill="#ccfbf1">Screen</text>
    <text x="622" y="180" text-anchor="middle" font-size="14" fill="#ccfbf1">reader</text>
    <text x="350" y="316" text-anchor="middle" font-size="14" fill="#94a3b8">Correct HTML fills this tree for free. ARIA only patches what HTML cannot express.</text>
  </g>
  <defs><marker id="a1" markerWidth="9" markerHeight="9" refX="8" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 z" fill="#64748b"/></marker></defs>
</svg>""",
    "placeholder": """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 500" role="img" aria-label="A neutral placeholder graphic used when a specific example image is not required.">
  <title>HTML Hero placeholder</title>
  <rect width="800" height="500" fill="#e2e8f0"/>
  <g fill="none" stroke="#94a3b8" stroke-width="3">
    <rect x="24" y="24" width="752" height="452" rx="16"/>
    <path d="M120 380 L300 200 L420 320 L520 240 L680 380"/>
  </g>
  <circle cx="580" cy="150" r="42" fill="#cbd5e1"/>
  <text x="400" y="446" text-anchor="middle" font-family="system-ui, sans-serif" font-size="22" fill="#475569">Sample image · HTML Hero learning media</text>
</svg>""",
}

ICONS: dict[str, str] = {
    "home": '<path d="M3 11.2 12 4l9 7.2V20a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1z"/>',
    "mail": '<path d="M3 6h18v12H3z"/><path d="m3 7 9 6 9-6"/>',
    "phone": '<path d="M5 3h4l2 5-3 2a12 12 0 0 0 6 6l2-3 5 2v4a1 1 0 0 1-1 1A18 18 0 0 1 3 4a1 1 0 0 1 1-1z"/>',
    "map-pin": '<path d="M12 22s7-6.2 7-11a7 7 0 1 0-14 0c0 4.8 7 11 7 11z"/><circle cx="12" cy="11" r="2.6"/>',
    "clock": '<circle cx="12" cy="12" r="9"/><path d="M12 7v5.2l3.4 2"/>',
    "star": '<path d="m12 3.6 2.6 5.4 5.9.8-4.3 4.1 1 5.9-5.2-2.8-5.2 2.8 1-5.9L3.5 9.8l5.9-.8z"/>',
    "check": '<path d="m4.5 12.5 5 5 10-11"/>',
    "search": '<circle cx="11" cy="11" r="6.5"/><path d="m16 16 4.5 4.5"/>',
    "menu": '<path d="M4 7h16M4 12h16M4 17h16"/>',
    "download": '<path d="M12 4v11"/><path d="m7.5 11 4.5 4.5L16.5 11"/><path d="M4.5 20h15"/>',
    "play": '<path d="M8 5.5 18.5 12 8 18.5z"/>',
    "calendar": '<rect x="3.5" y="5" width="17" height="16" rx="2"/><path d="M3.5 10h17M8 3.5v3M16 3.5v3"/>',
}

ICON_TEMPLATE = (
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" '
    'fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" '
    'stroke-linejoin="round" aria-hidden="true" focusable="false">{body}</svg>'
)


def build_svgs() -> list[str]:
    written = []
    for name, markup in SVGS.items():
        (DIRS["svg"] / f"{name}.svg").write_text(markup.strip() + "\n", encoding="utf-8")
        written.append(name)
        print(f"  svg: {name}")
    for name, body in ICONS.items():
        (DIRS["icons"] / f"{name}.svg").write_text(ICON_TEMPLATE.format(body=body) + "\n", encoding="utf-8")
    return written


# --------------------------------------------------------------------------
# Video + audio
# --------------------------------------------------------------------------
def run_ffmpeg(args: list[str]) -> None:
    if not FFMPEG:
        raise RuntimeError("ffmpeg is not available; install imageio-ffmpeg or ffmpeg")
    proc = subprocess.run([FFMPEG, "-y", "-loglevel", "error", *args], capture_output=True, text=True)
    if proc.returncode != 0:
        raise RuntimeError(f"ffmpeg failed: {proc.stderr[-800:]}")


@dataclass
class VideoSpec:
    slug: str
    title: str
    frames: int
    fps: int
    painter: object


def frame_tag_tour(i: int, n: int, size=(1280, 720)) -> Image.Image:
    """Animated explainer: tags being typed and a page assembling itself."""
    w, h = size
    t = i / n
    img = Image.new("RGB", (w, h), (13, 18, 33))
    d = ImageDraw.Draw(img)
    title_f, code_f, small_f = load_font(40, True), load_font(30), load_font(22)

    d.rectangle((0, 0, w, 84), fill=(20, 28, 48))
    d.text((44, 42), "How an HTML page is built", font=title_f, fill=(226, 232, 240), anchor="lm")

    lines = [
        ("<!DOCTYPE html>", (148, 163, 184)),
        ("<html lang=\"en\">", (56, 189, 248)),
        ("  <head>", (56, 189, 248)),
        ("    <title>My page</title>", (250, 204, 21)),
        ("  </head>", (56, 189, 248)),
        ("  <body>", (56, 189, 248)),
        ("    <h1>Hello</h1>", (167, 243, 208)),
        ("  </body>", (56, 189, 248)),
        ("</html>", (56, 189, 248)),
    ]
    total_chars = sum(len(s) for s, _ in lines)
    typed = int(total_chars * min(1.0, t * 1.5))
    y, used = 130, 0
    for text, colour in lines:
        show = max(0, min(len(text), typed - used))
        if show:
            d.text((44, y), text[:show], font=code_f, fill=colour)
        used += len(text)
        y += 44

    # The rendered result panel appears as the code completes.
    px, py, pw, ph = 720, 130, 500, 420
    d.rounded_rectangle((px, py, px + pw, py + ph), radius=14, fill=(248, 250, 252))
    d.rectangle((px, py, px + pw, py + 40), fill=(226, 232, 240))
    d.text((px + 16, py + 20), "browser preview", font=small_f, fill=(71, 85, 105), anchor="lm")
    if t > 0.55:
        a = min(1.0, (t - 0.55) / 0.25)
        d.text((px + 30, py + 110), "Hello", font=load_font(int(20 + 46 * a), True), fill=(15, 23, 42))
    if t > 0.8:
        d.text((px + 30, py + 210), "The <h1> became", font=small_f, fill=(71, 85, 105))
        d.text((px + 30, py + 240), "big bold text.", font=small_f, fill=(71, 85, 105))
    return img


def frame_responsive(i: int, n: int, size=(1280, 720)) -> Image.Image:
    """Animated explainer: a layout reflowing as the viewport narrows."""
    w, h = size
    t = i / n
    img = Image.new("RGB", (w, h), (248, 250, 252))
    d = ImageDraw.Draw(img)
    d.rectangle((0, 0, w, 80), fill=(15, 23, 42))
    d.text((44, 40), "One page, every screen size", font=load_font(36, True), fill=(241, 245, 249), anchor="lm")

    # Viewport width sweeps wide -> narrow -> wide.
    phase = math.sin(t * math.tau - math.pi / 2) * 0.5 + 0.5
    vw = int(lerp(1080, 380, phase))
    vx = (w - vw) // 2
    vy, vh = 120, 520
    d.rounded_rectangle((vx, vy, vx + vw, vy + vh), radius=16, fill=(255, 255, 255), outline=(203, 213, 225), width=3)
    d.rectangle((vx + 3, vy + 3, vx + vw - 3, vy + 46), fill=(226, 232, 240))
    d.text((vx + vw / 2, vy + 24), f"{vw} px wide", font=load_font(20), fill=(71, 85, 105), anchor="mm")

    pad = 22
    inner_x, inner_y = vx + pad, vy + 70
    inner_w = vw - pad * 2
    d.rounded_rectangle((inner_x, inner_y, inner_x + inner_w, inner_y + 110), radius=8, fill=(30, 64, 175))
    cols = 3 if vw > 900 else (2 if vw > 560 else 1)
    gap, cy = 16, inner_y + 130
    cw = (inner_w - gap * (cols - 1)) // cols
    for k in range(6):
        col, row = k % cols, k // cols
        cx = inner_x + col * (cw + gap)
        yy = cy + row * 106
        if yy + 92 > vy + vh - 16:
            break
        d.rounded_rectangle((cx, yy, cx + cw, yy + 92), radius=8, fill=(226, 232, 240))
        d.rounded_rectangle((cx + 10, yy + 12, cx + min(cw - 20, 90), yy + 52), radius=6, fill=(96, 165, 250))
        d.rectangle((cx + 10, yy + 66, cx + cw - 24, yy + 74), fill=(148, 163, 184))
    d.text((w / 2, 668), f"{cols} column{'s' if cols > 1 else ''} — the content decides, not the device",
           font=load_font(22), fill=(71, 85, 105), anchor="mm")
    return img


VIDEOS = [
    VideoSpec("page-anatomy", "How an HTML page is built", 240, 24, frame_tag_tour),
    VideoSpec("responsive-layout", "One page, every screen size", 264, 24, frame_responsive),
]


def build_videos() -> list[dict]:
    records = []
    for spec in VIDEOS:
        print(f"  video: {spec.slug}")
        with tempfile.TemporaryDirectory() as tmp:
            tmpdir = Path(tmp)
            for i in range(spec.frames):
                frame = spec.painter(i, spec.frames)  # type: ignore[operator]
                frame.save(tmpdir / f"f{i:05d}.png")
            mp4 = DIRS["video"] / f"{spec.slug}.mp4"
            run_ffmpeg(
                ["-framerate", str(spec.fps), "-i", str(tmpdir / "f%05d.png"),
                 "-c:v", "libx264", "-pix_fmt", "yuv420p", "-crf", "26",
                 "-movflags", "+faststart", str(mp4)]
            )
            webm = DIRS["video"] / f"{spec.slug}.webm"
            run_ffmpeg(
                ["-framerate", str(spec.fps), "-i", str(tmpdir / "f%05d.png"),
                 "-c:v", "libvpx-vp9", "-b:v", "0", "-crf", "38", "-row-mt", "1", str(webm)]
            )
            poster = spec.painter(int(spec.frames * 0.62), spec.frames)  # type: ignore[operator]
            poster.save(DIRS["posters"] / f"{spec.slug}.jpg", "JPEG", quality=84, optimize=True)
        records.append({"slug": spec.slug, "title": spec.title,
                        "duration": round(spec.frames / spec.fps, 2)})
    return records


CAPTIONS = {
    "page-anatomy": """WEBVTT

00:00:00.000 --> 00:00:03.000
Every web page starts as a plain text file.

00:00:03.000 --> 00:00:06.500
The doctype tells the browser to use modern HTML rules.

00:00:06.500 --> 00:00:10.000
The html element wraps everything, and lang says which language the page is in.

00:00:10.000 --> 00:00:00.000
""",
    "responsive-layout": """WEBVTT

00:00:00.000 --> 00:00:03.500
The same HTML has to work on a phone and on a wide monitor.

00:00:03.500 --> 00:00:07.000
As the window narrows, the cards stack instead of shrinking.

00:00:07.000 --> 00:00:11.000
HTML supplies the structure; the layout adapts around it.
""",
}


def build_captions() -> list[str]:
    written = []
    for slug, body in CAPTIONS.items():
        # Repair the intentionally simple authoring above into valid, ordered cues.
        cues = [c for c in body.strip().split("\n\n") if "-->" in c]
        text = "WEBVTT\n\n" + "\n\n".join(cues) + "\n"
        (DIRS["captions"] / f"{slug}.en.vtt").write_text(text, encoding="utf-8")
        written.append(slug)
        print(f"  captions: {slug}")
    return written


@dataclass
class AudioSpec:
    slug: str
    title: str
    expr: str
    seconds: float


AUDIOS = [
    AudioSpec(
        "welcome-chime",
        "Welcome chime",
        # A short major-triad bell with an exponential decay envelope.
        "0.32*exp(-3.2*t)*(sin(2*PI*523.25*t)+0.7*sin(2*PI*659.25*t)+0.5*sin(2*PI*783.99*t))",
        3.0,
    ),
    AudioSpec(
        "calm-loop",
        "Calm ambient loop",
        # Two slowly detuned sines with a gentle tremolo — loops cleanly.
        "0.22*(0.5+0.5*sin(2*PI*0.25*t))*(sin(2*PI*220*t)+0.6*sin(2*PI*277.18*t)+0.4*sin(2*PI*329.63*t))",
        8.0,
    ),
]


def build_audio() -> list[dict]:
    records = []
    for spec in AUDIOS:
        print(f"  audio: {spec.slug}")
        wav = DIRS["audio"] / f"{spec.slug}.wav"
        run_ffmpeg(["-f", "lavfi", "-i",
                    f"aevalsrc={spec.expr}:s=44100:d={spec.seconds}",
                    "-ac", "1", "-c:a", "pcm_s16le", str(wav)])
        mp3 = DIRS["audio"] / f"{spec.slug}.mp3"
        run_ffmpeg(["-i", str(wav), "-c:a", "libmp3lame", "-b:a", "128k", str(mp3)])
        records.append({"slug": spec.slug, "title": spec.title, "duration": spec.seconds})
    return records


def build_favicon() -> None:
    """The favicon used by the platform and offered to learners for their projects."""
    svg = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" role="img" aria-label="HTML Hero logo">
  <title>HTML Hero</title>
  <rect width="64" height="64" rx="14" fill="#1d4ed8"/>
  <path d="M20 20v24M20 32h11M31 20v24" stroke="#fff" stroke-width="5" stroke-linecap="round" fill="none"/>
  <path d="M40 22 48 32l-8 10" stroke="#93c5fd" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
</svg>
"""
    (MEDIA / "favicon.svg").write_text(svg, encoding="utf-8")
    img = Image.new("RGB", (256, 256), (29, 78, 216))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle((0, 0, 255, 255), radius=56, fill=(29, 78, 216))
    d.line([(80, 80), (80, 176)], fill=(255, 255, 255), width=20)
    d.line([(80, 128), (124, 128)], fill=(255, 255, 255), width=20)
    d.line([(124, 80), (124, 176)], fill=(255, 255, 255), width=20)
    d.line([(160, 88), (192, 128), (160, 168)], fill=(147, 197, 253), width=20, joint="curve")
    img.save(MEDIA / "favicon.png", "PNG")
    # The .ico must be RGBA — Next.js rejects palette or RGB icons at build time.
    icon = Image.new("RGBA", (256, 256), (0, 0, 0, 0))
    ImageDraw.Draw(icon).rounded_rectangle((0, 0, 255, 255), radius=56, fill=(29, 78, 216, 255))
    id_ = ImageDraw.Draw(icon)
    id_.line([(80, 80), (80, 176)], fill=(255, 255, 255, 255), width=20)
    id_.line([(80, 128), (124, 128)], fill=(255, 255, 255, 255), width=20)
    id_.line([(124, 80), (124, 176)], fill=(255, 255, 255, 255), width=20)
    id_.line([(160, 88), (192, 128), (160, 168)], fill=(147, 197, 253, 255), width=20, joint="curve")
    icon.save(ROOT / "src" / "app" / "favicon.ico", sizes=[(32, 32), (16, 16)])


def main() -> int:
    for path in DIRS.values():
        path.mkdir(parents=True, exist_ok=True)
    print("Generating original learning media (CC0-1.0)…")
    rasters = build_rasters()
    svgs = build_svgs()
    videos = build_videos()
    captions = build_captions()
    audio = build_audio()
    build_favicon()

    summary = {
        "generator": "scripts/generate_media.py",
        "licence": "CC0-1.0",
        "rasters": rasters,
        "svgs": svgs,
        "videos": videos,
        "captions": captions,
        "audio": audio,
    }
    (MEDIA / "generated.json").write_text(json.dumps(summary, indent=2) + "\n", encoding="utf-8")
    total = sum(1 for _ in MEDIA.rglob("*") if _.is_file())
    print(f"Done. {total} files under public/learning-media.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

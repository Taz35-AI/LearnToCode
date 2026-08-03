# Reimbursement Tracker

A simple, fast tracker for company invoices and expenses paid on a **personal card**,
so the director can see exactly what the company still owes him and mark payments
as reimbursed when he pays himself back.

## What it does

- **Add a payment** with: date, reference (invoice number), supplier, description,
  and amount. Supplier is **optional** — expenses like parking or tolls that have no
  supplier are fully supported.
- **VAT handled automatically**: pick Standard 20%, Reduced 5%, No VAT / zero-rated
  (e.g. parking), or a custom rate. Type the **gross** (what was charged to the card)
  and the **net** is calculated automatically — or type the net and the gross is
  calculated instead.
- **Reimbursement status**: every payment is *Outstanding* until you click
  **Reimburse**, which records the reimbursement date. The summary at the top always
  shows the total currently owed.
- **Search & filter** by reference, supplier, description or status.
- **Export CSV** for the accountant / bookkeeping.
- **Backup & Restore** as a JSON file (data lives in the browser's local storage).

## How to use it

It's a plain static web app — no install, no build, no server.

- **Locally:** just open `index.html` in a browser.
- **Hosted:** deploy the repo to any static host (Vercel, Netlify, GitHub Pages).

## Important: where the data lives

Entries are saved in **that browser on that device** (localStorage). They are not
synced anywhere. Use the **Backup** button regularly and keep the JSON file safe —
**Restore** brings everything back on a new device or after clearing the browser.

## Files

| File | Purpose |
| --- | --- |
| `index.html` | Page structure: summary cards, entry form, payments table |
| `styles.css` | All styling |
| `app.js` | Logic: VAT/net/gross calculation, storage, filtering, CSV export, backup |

Amounts are stored internally as integer pence to avoid floating-point rounding errors.

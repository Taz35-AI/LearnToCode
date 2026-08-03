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

## Where the data lives

Two modes, chosen automatically from `config.js`:

- **Supabase mode** (recommended): fill in `SUPABASE_URL` and `SUPABASE_ANON_KEY`
  in `config.js`. Data is stored in a shared Supabase database behind a sign-in,
  so it syncs across devices and everyone who signs in sees the same list.
- **Local mode**: leave `config.js` empty. Entries are saved in that browser only
  (localStorage). Use **Backup** regularly.

### Connecting Supabase (one-time setup)

1. In the [Supabase dashboard](https://supabase.com/dashboard), open your project.
2. **SQL Editor** → New query → paste and run `supabase/schema.sql`. This creates
   the `payments` table with Row Level Security (only signed-in users can access it).
3. **Authentication → Users → Add user** — create an account for each person
   (tick *Auto Confirm User*).
4. **Authentication → Sign In / Up** — turn **off** "Allow new users to sign up",
   so nobody else can create an account.
5. **Project Settings → API** — copy the *Project URL* and *anon public* key into
   `config.js`, commit, and deploy.

On first sign-in, if the browser still has entries from local mode and the
database is empty, the app offers to upload them automatically.

## Files

| File | Purpose |
| --- | --- |
| `index.html` | Page structure: summary cards, entry form, payments table, sign-in |
| `styles.css` | All styling |
| `app.js` | Logic: VAT/net/gross calculation, storage backends, auth, CSV export |
| `config.js` | Supabase URL + anon key (empty = local mode) |
| `supabase/schema.sql` | Database table + Row Level Security, run once in Supabase |

Amounts are stored internally as integer pence to avoid floating-point rounding errors.

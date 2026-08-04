"use strict";

/* =========================================================
 * Reimbursement Tracker
 * All amounts are stored as integer pence to avoid floating
 * point errors. VAT is derived from gross (or gross from net)
 * at the entry's rate; a 0% rate covers no-VAT items such as
 * parking, where there may also be no supplier.
 * ======================================================= */

const STORAGE_KEY = "reimbursement-tracker:v1";
const CURRENCY = "£";

/* ---------- Money helpers ---------- */

function poundsToPence(value) {
  const parsed = Number.parseFloat(value);
  if (!Number.isFinite(parsed) || parsed < 0) return null;
  return Math.round(parsed * 100);
}

function penceToPounds(pence) {
  return (pence / 100).toFixed(2);
}

function formatMoney(pence) {
  return `${CURRENCY}${(pence / 100).toLocaleString("en-GB", {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  })}`;
}

/** Given gross pence and a VAT % rate, split into net + VAT. */
function splitFromGross(grossPence, vatRate) {
  const netPence = Math.round(grossPence / (1 + vatRate / 100));
  return { netPence, vatPence: grossPence - netPence };
}

/** Given net pence and a VAT % rate, compute gross + VAT. */
function grossFromNet(netPence, vatRate) {
  const grossPence = Math.round(netPence * (1 + vatRate / 100));
  return { grossPence, vatPence: grossPence - netPence };
}

function formatDate(isoDate) {
  if (!isoDate) return "";
  const [year, month, day] = isoDate.split("-");
  return `${day}/${month}/${year}`;
}

function todayIso() {
  const now = new Date();
  const month = String(now.getMonth() + 1).padStart(2, "0");
  const day = String(now.getDate()).padStart(2, "0");
  return `${now.getFullYear()}-${month}-${day}`;
}

/* ---------- Storage ---------- */

function loadEntries() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return [];
    const parsed = JSON.parse(raw);
    return Array.isArray(parsed) ? parsed.filter(isValidEntry) : [];
  } catch (error) {
    console.error("Could not load saved data:", error);
    return [];
  }
}

function saveEntries(entries) {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(entries));
  } catch (error) {
    console.error("Could not save data:", error);
    alert("Saving failed — your browser storage may be full or blocked.");
  }
}

function isValidEntry(entry) {
  return (
    entry &&
    typeof entry.id === "string" &&
    typeof entry.date === "string" &&
    Number.isInteger(entry.grossPence) &&
    Number.isInteger(entry.netPence) &&
    Number.isInteger(entry.vatPence)
  );
}

/* ---------- State ---------- */

let entries = loadEntries();
let editingId = null; // id of the entry being edited, or null when adding

/* ---------- DOM references ---------- */

const form = document.getElementById("entry-form");
const formTitle = document.getElementById("form-title");
const saveBtn = document.getElementById("save-btn");
const cancelEditBtn = document.getElementById("cancel-edit-btn");

const dateInput = document.getElementById("f-date");
const referenceInput = document.getElementById("f-reference");
const supplierInput = document.getElementById("f-supplier");
const descriptionInput = document.getElementById("f-description");
const vatSelect = document.getElementById("f-vat");
const customVatField = document.getElementById("custom-vat-field");
const customVatInput = document.getElementById("f-vat-custom");
const grossInput = document.getElementById("f-gross");
const netInput = document.getElementById("f-net");
const vatPreview = document.getElementById("vat-preview");

const searchInput = document.getElementById("filter-search");
const statusFilter = document.getElementById("filter-status");
const tableBody = document.getElementById("entries-body");
const emptyState = document.getElementById("empty-state");

/* ---------- VAT rate from the form ---------- */

function currentVatRate() {
  if (vatSelect.value !== "custom") return Number.parseFloat(vatSelect.value);
  const custom = Number.parseFloat(customVatInput.value);
  return Number.isFinite(custom) && custom >= 0 && custom <= 100 ? custom : 0;
}

/* Recalculate the counterpart amount when gross or net is typed. */
function recalcFromGross() {
  const grossPence = poundsToPence(grossInput.value);
  if (grossPence === null) {
    vatPreview.textContent = "VAT: —";
    return;
  }
  const { netPence, vatPence } = splitFromGross(grossPence, currentVatRate());
  netInput.value = penceToPounds(netPence);
  vatPreview.textContent = `VAT: ${formatMoney(vatPence)}`;
}

function recalcFromNet() {
  const netPence = poundsToPence(netInput.value);
  if (netPence === null) {
    vatPreview.textContent = "VAT: —";
    return;
  }
  const { grossPence, vatPence } = grossFromNet(netPence, currentVatRate());
  grossInput.value = penceToPounds(grossPence);
  vatPreview.textContent = `VAT: ${formatMoney(vatPence)}`;
}

/* ---------- Form handling ---------- */

function resetForm() {
  form.reset();
  dateInput.value = todayIso();
  customVatField.hidden = true;
  vatPreview.textContent = "VAT: —";
  editingId = null;
  formTitle.textContent = "Add a payment";
  saveBtn.textContent = "Add payment";
  cancelEditBtn.hidden = true;
}

function startEditing(entry) {
  editingId = entry.id;
  dateInput.value = entry.date;
  referenceInput.value = entry.reference;
  supplierInput.value = entry.supplier;
  descriptionInput.value = entry.description;

  const presetRates = ["20", "5", "0"];
  const rateString = String(entry.vatRate);
  if (presetRates.includes(rateString)) {
    vatSelect.value = rateString;
    customVatField.hidden = true;
  } else {
    vatSelect.value = "custom";
    customVatInput.value = entry.vatRate;
    customVatField.hidden = false;
  }

  grossInput.value = penceToPounds(entry.grossPence);
  netInput.value = penceToPounds(entry.netPence);
  vatPreview.textContent = `VAT: ${formatMoney(entry.vatPence)}`;

  formTitle.textContent = "Edit payment";
  saveBtn.textContent = "Save changes";
  cancelEditBtn.hidden = false;
  form.scrollIntoView({ behavior: "smooth", block: "start" });
}

function handleSubmit(event) {
  event.preventDefault();

  const grossPence = poundsToPence(grossInput.value);
  if (grossPence === null || grossPence === 0) {
    alert("Please enter a gross (or net) amount greater than zero.");
    return;
  }

  const vatRate = currentVatRate();
  const { netPence, vatPence } = splitFromGross(grossPence, vatRate);

  const existing = editingId ? entries.find((e) => e.id === editingId) : null;
  const entry = {
    id: existing ? existing.id : crypto.randomUUID(),
    date: dateInput.value,
    reference: referenceInput.value.trim(),
    supplier: supplierInput.value.trim(),
    description: descriptionInput.value.trim(),
    vatRate,
    grossPence,
    netPence,
    vatPence,
    reimbursed: existing ? existing.reimbursed : false,
    reimbursedDate: existing ? existing.reimbursedDate : null,
    createdAt: existing ? existing.createdAt : new Date().toISOString(),
  };

  if (existing) {
    entries = entries.map((e) => (e.id === editingId ? entry : e));
  } else {
    entries.push(entry);
  }

  saveEntries(entries);
  resetForm();
  render();
}

/* ---------- Row actions ---------- */

function toggleReimbursed(id) {
  const entry = entries.find((e) => e.id === id);
  if (!entry) return;

  if (entry.reimbursed) {
    const undo = confirm("Mark this payment as NOT reimbursed again?");
    if (!undo) return;
    entry.reimbursed = false;
    entry.reimbursedDate = null;
  } else {
    const suggested = todayIso();
    const input = prompt("Date reimbursed (YYYY-MM-DD):", suggested);
    if (input === null) return; // cancelled
    const date = /^\d{4}-\d{2}-\d{2}$/.test(input.trim()) ? input.trim() : suggested;
    entry.reimbursed = true;
    entry.reimbursedDate = date;
  }

  saveEntries(entries);
  render();
}

function deleteEntry(id) {
  const entry = entries.find((e) => e.id === id);
  if (!entry) return;
  const label = entry.reference || entry.description || formatMoney(entry.grossPence);
  if (!confirm(`Delete "${label}"? This cannot be undone.`)) return;
  entries = entries.filter((e) => e.id !== id);
  if (editingId === id) resetForm();
  saveEntries(entries);
  render();
}

/* ---------- Filtering ---------- */

function visibleEntries() {
  const query = searchInput.value.trim().toLowerCase();
  const status = statusFilter.value;

  return entries
    .filter((entry) => {
      if (status === "outstanding" && entry.reimbursed) return false;
      if (status === "reimbursed" && !entry.reimbursed) return false;
      if (!query) return true;
      const haystack = `${entry.reference} ${entry.supplier} ${entry.description}`.toLowerCase();
      return haystack.includes(query);
    })
    .sort((a, b) => b.date.localeCompare(a.date) || b.createdAt.localeCompare(a.createdAt));
}

/* ---------- Rendering ---------- */

function render() {
  renderSummary();
  renderTable();
}

function renderSummary() {
  const outstanding = entries.filter((e) => !e.reimbursed);
  const reimbursed = entries.filter((e) => e.reimbursed);
  const sum = (list, key) => list.reduce((total, e) => total + e[key], 0);

  document.getElementById("sum-outstanding").textContent = formatMoney(sum(outstanding, "grossPence"));
  document.getElementById("sum-outstanding-count").textContent =
    `${outstanding.length} payment${outstanding.length === 1 ? "" : "s"}`;
  document.getElementById("sum-reimbursed").textContent = formatMoney(sum(reimbursed, "grossPence"));
  document.getElementById("sum-reimbursed-count").textContent =
    `${reimbursed.length} payment${reimbursed.length === 1 ? "" : "s"}`;
  document.getElementById("sum-vat").textContent = formatMoney(sum(entries, "vatPence"));
}

function renderTable() {
  const visible = visibleEntries();
  tableBody.textContent = "";
  emptyState.hidden = entries.length > 0;

  for (const entry of visible) {
    tableBody.appendChild(buildRow(entry));
  }

  const sum = (key) => visible.reduce((total, e) => total + e[key], 0);
  document.getElementById("total-net").textContent = formatMoney(sum("netPence"));
  document.getElementById("total-vat").textContent = formatMoney(sum("vatPence"));
  document.getElementById("total-gross").textContent = formatMoney(sum("grossPence"));
}

function buildRow(entry) {
  const row = document.createElement("tr");

  const cells = [
    text(formatDate(entry.date)),
    text(entry.reference || "—"),
    entry.supplier ? text(entry.supplier) : muted("no supplier"),
    text(entry.description || "—", "wrap"),
    text(formatMoney(entry.netPence), "num"),
    text(`${formatMoney(entry.vatPence)}${entry.vatRate === 0 ? " (no VAT)" : ""}`, "num"),
    text(formatMoney(entry.grossPence), "num"),
  ];
  cells.forEach((cell) => row.appendChild(cell));

  const statusCell = document.createElement("td");
  const badge = document.createElement("span");
  badge.className = `badge ${entry.reimbursed ? "badge-reimbursed" : "badge-outstanding"}`;
  badge.textContent = entry.reimbursed
    ? `Reimbursed ${formatDate(entry.reimbursedDate)}`
    : "Outstanding";
  statusCell.appendChild(badge);
  row.appendChild(statusCell);

  const actionsCell = document.createElement("td");
  const actions = document.createElement("div");
  actions.className = "row-actions";
  actions.append(
    actionButton(entry.reimbursed ? "Undo" : "Reimburse", "btn-link", () => toggleReimbursed(entry.id)),
    actionButton("Edit", "btn-link", () => startEditing(entry)),
    actionButton("Delete", "btn-danger-text", () => deleteEntry(entry.id)),
  );
  actionsCell.appendChild(actions);
  row.appendChild(actionsCell);

  return row;
}

function text(content, className = "") {
  const cell = document.createElement("td");
  cell.textContent = content;
  if (className) cell.className = className;
  return cell;
}

function muted(content) {
  const cell = document.createElement("td");
  const span = document.createElement("span");
  span.className = "no-supplier";
  span.textContent = content;
  cell.appendChild(span);
  return cell;
}

function actionButton(label, className, onClick) {
  const button = document.createElement("button");
  button.type = "button";
  button.className = `btn btn-small ${className}`;
  button.textContent = label;
  button.addEventListener("click", onClick);
  return button;
}

/* ---------- CSV export ---------- */

function exportCsv() {
  if (entries.length === 0) {
    alert("Nothing to export yet.");
    return;
  }

  const header = [
    "Date", "Reference", "Supplier", "Description",
    "VAT Rate %", "Net", "VAT", "Gross", "Status", "Reimbursed Date",
  ];

  const escape = (value) => `"${String(value).replaceAll('"', '""')}"`;
  const rows = [...entries]
    .sort((a, b) => a.date.localeCompare(b.date))
    .map((e) => [
      e.date, e.reference, e.supplier || "No supplier", e.description,
      e.vatRate, penceToPounds(e.netPence), penceToPounds(e.vatPence),
      penceToPounds(e.grossPence),
      e.reimbursed ? "Reimbursed" : "Outstanding",
      e.reimbursedDate || "",
    ].map(escape).join(","));

  downloadFile(
    [header.map(escape).join(","), ...rows].join("\n"),
    `reimbursements-${todayIso()}.csv`,
    "text/csv",
  );
}

/* ---------- Backup / restore ---------- */

function exportBackup() {
  downloadFile(JSON.stringify(entries, null, 2), `reimbursements-backup-${todayIso()}.json`, "application/json");
}

function restoreBackup(file) {
  const reader = new FileReader();
  reader.onload = () => {
    try {
      const restored = JSON.parse(reader.result);
      if (!Array.isArray(restored) || !restored.every(isValidEntry)) {
        throw new Error("Not a valid backup file");
      }
      if (entries.length > 0 && !confirm(`Replace the ${entries.length} current entries with the ${restored.length} entries in this backup?`)) {
        return;
      }
      entries = restored;
      saveEntries(entries);
      resetForm();
      render();
    } catch (error) {
      console.error("Restore failed:", error);
      alert("That file is not a valid backup from this app.");
    }
  };
  reader.onerror = () => alert("Could not read the file.");
  reader.readAsText(file);
}

function downloadFile(content, filename, mimeType) {
  const blob = new Blob([content], { type: mimeType });
  const url = URL.createObjectURL(blob);
  const link = document.createElement("a");
  link.href = url;
  link.download = filename;
  link.click();
  URL.revokeObjectURL(url);
}

/* ---------- Wire-up ---------- */

form.addEventListener("submit", handleSubmit);
cancelEditBtn.addEventListener("click", resetForm);

vatSelect.addEventListener("change", () => {
  customVatField.hidden = vatSelect.value !== "custom";
  recalcFromGross();
});
customVatInput.addEventListener("input", recalcFromGross);
grossInput.addEventListener("input", recalcFromGross);
netInput.addEventListener("input", recalcFromNet);

searchInput.addEventListener("input", renderTable);
statusFilter.addEventListener("change", renderTable);

document.getElementById("export-csv-btn").addEventListener("click", exportCsv);
document.getElementById("backup-btn").addEventListener("click", exportBackup);
document.getElementById("restore-input").addEventListener("change", (event) => {
  const [file] = event.target.files;
  if (file) restoreBackup(file);
  event.target.value = ""; // allow re-selecting the same file
});

resetForm();
render();

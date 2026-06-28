/**
 * Logic admin/index.php: list + CRUD laptop.
 * window.API_BASE harus di-set di halaman (relatif terhadap lokasi file ini).
 */

const API = window.API_BASE || '../api/laptops.php';

const elTableBody = document.getElementById('adminTableBody');
const elSearch = document.getElementById('adminSearch');
const elAddBtn = document.getElementById('addLaptopBtn');
const elModalOverlay = document.getElementById('laptopModalOverlay');
const elModalTitle = document.getElementById('laptopModalTitle');
const elForm = document.getElementById('laptopForm');
const elCancelBtn = document.getElementById('cancelModalBtn');
const elDeleteOverlay = document.getElementById('deleteOverlay');
const elConfirmDeleteBtn = document.getElementById('confirmDeleteBtn');
const elCancelDeleteBtn = document.getElementById('cancelDeleteBtn');

let editingId = null;
let pendingDeleteId = null;
let debounceTimer = null;

function escapeHtml(str) {
  const div = document.createElement('div');
  div.textContent = str ?? '';
  return div.innerHTML;
}

async function loadTable() {
  const params = new URLSearchParams({ action: 'list' });
  if (elSearch.value.trim()) params.set('q', elSearch.value.trim());

  elTableBody.innerHTML = `<tr><td colspan="7">Memuat data...</td></tr>`;

  try {
    const laptops = await apiFetch(`${API}?${params.toString()}`);
    if (!laptops.length) {
      elTableBody.innerHTML = `<tr><td colspan="7">Belum ada data laptop.</td></tr>`;
      return;
    }
    elTableBody.innerHTML = laptops
      .map(
        (l) => `
        <tr data-id="${l.laptop_id}">
          <td>${escapeHtml(l.brand)}</td>
          <td>${escapeHtml(l.name)}</td>
          <td class="num">${formatRupiah(l.price)}</td>
          <td class="num">${l.ram_gb}GB</td>
          <td class="num">${l.storage_gb}GB</td>
          <td class="num">${l.spec_rating}</td>
          <td>
            <div class="row-actions">
              <button class="btn btn-sm btn-outline edit-btn" data-id="${l.laptop_id}">Edit</button>
              <button class="btn btn-sm btn-danger delete-btn" data-id="${l.laptop_id}">Hapus</button>
            </div>
          </td>
        </tr>`
      )
      .join('');
  } catch (e) {
    elTableBody.innerHTML = `<tr><td colspan="7">Gagal memuat data: ${escapeHtml(e.message)}</td></tr>`;
  }
}

function openModal(mode, laptop = null) {
  editingId = mode === 'edit' ? laptop.laptop_id : null;
  elModalTitle.textContent = mode === 'edit' ? 'Edit Laptop' : 'Tambah Laptop';
  elForm.reset();

  if (laptop) {
    Object.keys(laptop).forEach((key) => {
      const input = elForm.elements.namedItem(key);
      if (input) input.value = laptop[key];
    });
  }
  elModalOverlay.classList.remove('hidden');
}

function closeModal() {
  elModalOverlay.classList.add('hidden');
  editingId = null;
}

elAddBtn.addEventListener('click', () => openModal('add'));
elCancelBtn.addEventListener('click', closeModal);

elTableBody.addEventListener('click', async (e) => {
  const editBtn = e.target.closest('.edit-btn');
  const deleteBtn = e.target.closest('.delete-btn');

  if (editBtn) {
    const id = Number(editBtn.dataset.id);
    try {
      const laptop = await apiFetch(`${API}?action=get&id=${id}`);
      openModal('edit', laptop);
    } catch (err) {
      showToast(err.message, 'error');
    }
  }

  if (deleteBtn) {
    pendingDeleteId = Number(deleteBtn.dataset.id);
    elDeleteOverlay.classList.remove('hidden');
  }
});

elCancelDeleteBtn.addEventListener('click', () => {
  pendingDeleteId = null;
  elDeleteOverlay.classList.add('hidden');
});

elConfirmDeleteBtn.addEventListener('click', async () => {
  if (!pendingDeleteId) return;
  try {
    await apiFetch(`${API}?action=delete&id=${pendingDeleteId}`, { method: 'DELETE' });
    showToast('Laptop berhasil dihapus.');
    elDeleteOverlay.classList.add('hidden');
    pendingDeleteId = null;
    loadTable();
  } catch (err) {
    showToast(err.message, 'error');
  }
});

elForm.addEventListener('submit', async (e) => {
  e.preventDefault();
  const formData = new FormData(elForm);
  const payload = {};
  formData.forEach((value, key) => {
    payload[key] = value;
  });

  // konversi field numerik
  ['price', 'spec_rating', 'ram_gb', 'storage_gb', 'resolution_width', 'resolution_height', 'warranty'].forEach((f) => {
    if (payload[f] !== undefined) payload[f] = Number(payload[f]);
  });

  try {
    if (editingId) {
      payload.laptop_id = editingId;
      await apiFetch(`${API}?action=update`, { method: 'PUT', body: JSON.stringify(payload) });
      showToast('Laptop berhasil diupdate.');
    } else {
      await apiFetch(`${API}?action=create`, { method: 'POST', body: JSON.stringify(payload) });
      showToast('Laptop berhasil ditambahkan.');
    }
    closeModal();
    loadTable();
  } catch (err) {
    showToast(err.message, 'error');
  }
});

elSearch.addEventListener('input', () => {
  clearTimeout(debounceTimer);
  debounceTimer = setTimeout(loadTable, 300);
});

loadTable();

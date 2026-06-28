/**
 * Logic halaman utama (index.php): render katalog laptop,
 * search/filter/sort, dan floating Compare Box.
 */

const elGrid = document.getElementById('laptopGrid');
const elSearch = document.getElementById('searchInput');
const elKebutuhan = document.getElementById('kebutuhanFilter');
const elSort = document.getElementById('sortSelect');
const elCompareBar = document.getElementById('compareBar');
const elCompareChips = document.getElementById('compareChips');
const elCompareCount = document.getElementById('compareCount');
const elCompareGo = document.getElementById('compareGoBtn');

let allLaptopsCache = {};
let debounceTimer = null;

function laptopCardTemplate(laptop) {
  const selected = CompareBox.has(laptop.laptop_id);
  const ids = CompareBox.getIds();
  const isFull = ids.length >= MAX_COMPARE && !selected;

  return `
    <article class="card ${selected ? 'is-selected' : ''}" data-id="${laptop.laptop_id}">
      <p class="card-brand">${escapeHtml(laptop.brand || '-')}</p>
      <h3 class="card-name">${escapeHtml(laptop.name || '-')}</h3>
      <p class="card-price mono">${formatRupiah(laptop.price)}</p>
      <span class="rating-badge"><span class="dot"></span> Rating Spek ${laptop.spec_rating ?? '-'}</span>
      <ul class="card-specs">
        <li>RAM <span>${laptop.ram_gb ?? '-'}GB ${escapeHtml(laptop.ram_type || '')}</span></li>
        <li>Storage <span>${laptop.storage_gb ?? '-'}GB ${escapeHtml(laptop.rom_type || '')}</span></li>
        <li>GPU <span>${escapeHtml(laptop.gpu || '-')}</span></li>
      </ul>
      <div class="card-actions">
        <button class="btn ${selected ? 'btn-accent' : 'btn-outline'} btn-block btn-sm toggle-compare-btn"
          data-id="${laptop.laptop_id}" ${isFull ? 'disabled' : ''}>
          ${selected ? '✓ Ditambahkan' : (isFull ? `Maks ${MAX_COMPARE} laptop` : '+ Tambah ke Compare')}
        </button>
      </div>
    </article>
  `;
}

function escapeHtml(str) {
  const div = document.createElement('div');
  div.textContent = str ?? '';
  return div.innerHTML;
}

async function loadLaptops() {
  const params = new URLSearchParams();
  if (elSearch.value.trim()) params.set('q', elSearch.value.trim());
  if (elKebutuhan.value) params.set('kebutuhan_id', elKebutuhan.value);
  if (elSort.value) params.set('sort', elSort.value);

  elGrid.innerHTML = '<p class="eyebrow">Memuat data...</p>';

  try {
    const laptops = await apiFetch(`api/laptops.php?action=list&${params.toString()}`);
    if (!laptops.length) {
      elGrid.innerHTML = `<div class="empty-state"><h3>Tidak ada laptop yang cocok</h3><p>Coba ubah kata kunci atau filter kebutuhan.</p></div>`;
      return;
    }
    allLaptopsCache = {};
    laptops.forEach((l) => (allLaptopsCache[l.laptop_id] = l));
    elGrid.innerHTML = laptops.map(laptopCardTemplate).join('');
  } catch (e) {
    elGrid.innerHTML = `<div class="empty-state"><h3>Gagal memuat data</h3><p>${escapeHtml(e.message)}</p></div>`;
  }
}

async function loadKebutuhanOptions() {
  try {
    const list = await apiFetch('api/laptops.php?action=kebutuhan');
    elKebutuhan.innerHTML =
      '<option value="">Semua Kebutuhan</option>' +
      list.map((k) => `<option value="${k.kebutuhan_id}">${escapeHtml(k.nama_kebutuhan)}</option>`).join('');
  } catch {
    /* diamkan, filter tetap optional */
  }
}

function renderCompareBar() {
  const ids = CompareBox.getIds();
  elCompareBar.classList.toggle('is-visible', ids.length > 0);
  elCompareCount.textContent = `${ids.length}/${MAX_COMPARE}`;
  elCompareGo.disabled = ids.length < 2;

  elCompareChips.innerHTML = ids
    .map((id) => {
      const l = allLaptopsCache[id];
      const label = l ? `${l.brand} ${l.name}` : `Laptop #${id}`;
      return `<span class="chip"><span>${escapeHtml(label)}</span><button data-remove="${id}" aria-label="Hapus dari compare">&times;</button></span>`;
    })
    .join('');
}

function toggleCompare(id) {
  const result = CompareBox.add(id);
  if (!result.ok) {
    showToast(result.reason, 'error');
    return;
  }
  renderCompareBar();
  reRenderGridSelectionState();
}

function reRenderGridSelectionState() {
  // re-render hanya tombol/state, tanpa re-fetch API
  document.querySelectorAll('.card').forEach((card) => {
    const id = Number(card.dataset.id);
    const selected = CompareBox.has(id);
    const ids = CompareBox.getIds();
    const isFull = ids.length >= MAX_COMPARE && !selected;
    card.classList.toggle('is-selected', selected);
    const btn = card.querySelector('.toggle-compare-btn');
    btn.disabled = isFull;
    btn.classList.toggle('btn-accent', selected);
    btn.classList.toggle('btn-outline', !selected);
    btn.textContent = selected ? '✓ Ditambahkan' : (isFull ? `Maks ${MAX_COMPARE} laptop` : '+ Tambah ke Compare');
  });
}

elGrid.addEventListener('click', (e) => {
  const btn = e.target.closest('.toggle-compare-btn');
  if (!btn) return;
  const id = Number(btn.dataset.id);
  if (CompareBox.has(id)) {
    CompareBox.remove(id);
    renderCompareBar();
    reRenderGridSelectionState();
  } else {
    toggleCompare(id);
  }
});

elCompareChips.addEventListener('click', (e) => {
  const btn = e.target.closest('[data-remove]');
  if (!btn) return;
  CompareBox.remove(Number(btn.dataset.remove));
  renderCompareBar();
  reRenderGridSelectionState();
});

elCompareGo.addEventListener('click', () => {
  const ids = CompareBox.getIds();
  if (ids.length < 2) return;
  window.location.href = `compare.php?ids=${ids.join(',')}`;
});

elSearch.addEventListener('input', () => {
  clearTimeout(debounceTimer);
  debounceTimer = setTimeout(loadLaptops, 300);
});
elKebutuhan.addEventListener('change', loadLaptops);
elSort.addEventListener('change', loadLaptops);

(async function init() {
  await loadKebutuhanOptions();
  await loadLaptops();
  renderCompareBar();
})();

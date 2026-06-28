/**
 * Logic halaman compare.php: ambil detail laptop dari ids di URL,
 * render tabel datasheet, highlight nilai terbaik per baris.
 */

const elWrap = document.getElementById('compareWrap');

function getIdsFromUrl() {
  const params = new URLSearchParams(window.location.search);
  const raw = params.get('ids') || '';
  return raw.split(',').map(Number).filter(Boolean).slice(0, MAX_COMPARE);
}

function resolutionPixels(l) {
  return (l.resolution_width || 0) * (l.resolution_height || 0);
}

// definisi baris spek: key, label, formatter, dan arah "lebih baik" (higher/lower/none)
const SPEC_ROWS = [
  { key: 'price', label: 'Harga', dir: 'lower', fmt: (l) => formatRupiah(l.price) },
  { key: 'spec_rating', label: 'Rating Spek', dir: 'higher', fmt: (l) => `${l.spec_rating ?? '-'} / 100` },
  { key: 'processor', label: 'Prosesor', dir: 'none', fmt: (l) => l.processor || '-' },
  { key: 'cpu', label: 'Core / Thread', dir: 'none', fmt: (l) => l.cpu || '-' },
  { key: 'ram', label: 'RAM', dir: 'higher', fmt: (l) => `${l.ram_gb ?? '-'}GB ${l.ram_type || ''}`, value: (l) => l.ram_gb || 0 },
  { key: 'storage', label: 'Storage', dir: 'higher', fmt: (l) => `${l.storage_gb ?? '-'}GB ${l.rom_type || ''}`, value: (l) => l.storage_gb || 0 },
  { key: 'gpu', label: 'GPU', dir: 'none', fmt: (l) => l.gpu || '-' },
  { key: 'display', label: 'Ukuran Layar', dir: 'higher', fmt: (l) => `${l.display_size || '-'}"`, value: (l) => parseFloat(l.display_size) || 0 },
  { key: 'resolution', label: 'Resolusi', dir: 'higher', fmt: (l) => `${l.resolution_width || '-'} x ${l.resolution_height || '-'}`, value: resolutionPixels },
  { key: 'warranty', label: 'Garansi', dir: 'higher', fmt: (l) => `${l.warranty ?? '-'} tahun`, value: (l) => l.warranty || 0 },
  { key: 'os', label: 'Sistem Operasi', dir: 'none', fmt: (l) => l.os || '-' },
];

function bestIndexForRow(row, laptops) {
  if (row.dir === 'none') return -1;
  const values = laptops.map((l) => (row.value ? row.value(l) : Number(l[row.key]) || 0));
  let bestVal = row.dir === 'higher' ? Math.max(...values) : Math.min(...values);
  // jika semua sama, tidak ada yang di-highlight
  const allEqual = values.every((v) => v === values[0]);
  if (allEqual) return -1;
  return values.indexOf(bestVal);
}

function render(laptops) {
  if (laptops.length < 2) {
    elWrap.innerHTML = `
      <div class="empty-state">
        <h3>Belum cukup laptop untuk dibandingkan</h3>
        <p>Pilih minimal 2 laptop dari halaman utama, lalu klik "Compare Now".</p>
        <br><a class="btn btn-primary" href="index.php">Kembali ke Katalog</a>
      </div>`;
    return;
  }

  const headCells = laptops
    .map(
      (l) => `<th>${escapeHtmlSafe(l.brand)} ${escapeHtmlSafe(l.name)}<span class="th-price">${formatRupiah(l.price)}</span></th>`
    )
    .join('');

  const bodyRows = SPEC_ROWS.map((row) => {
    const bestIdx = bestIndexForRow(row, laptops);
    const cells = laptops
      .map((l, i) => `<td class="${i === bestIdx ? 'best' : ''}">${escapeHtmlSafe(row.fmt(l))}</td>`)
      .join('');
    return `<tr><th>${row.label}</th>${cells}</tr>`;
  }).join('');

  const removeCells = laptops
    .map((l) => `<td class="remove-col"><button class="btn btn-sm btn-outline" data-remove="${l.laptop_id}">Hapus</button></td>`)
    .join('');

  elWrap.innerHTML = `
    <div class="compare-table-wrap">
      <table class="spec-sheet">
        <thead><tr><th>Spesifikasi</th>${headCells}</tr></thead>
        <tbody>
          ${bodyRows}
          <tr><th>&nbsp;</th>${removeCells}</tr>
        </tbody>
      </table>
    </div>
    <p class="auth-foot" style="text-align:left;margin-top:14px;">
      <span class="mono">●</span> Sel berwarna emas menandai nilai terbaik pada baris tersebut.
    </p>
  `;

  elWrap.querySelectorAll('[data-remove]').forEach((btn) => {
    btn.addEventListener('click', () => {
      const id = Number(btn.dataset.remove);
      const remaining = getIdsFromUrl().filter((x) => x !== id);
      CompareBox.remove(id);
      if (remaining.length < 2) {
        window.location.href = 'index.php';
      } else {
        window.location.href = `compare.php?ids=${remaining.join(',')}`;
      }
    });
  });
}

function escapeHtmlSafe(str) {
  const div = document.createElement('div');
  div.textContent = str ?? '';
  return div.innerHTML;
}

(async function init() {
  const ids = getIdsFromUrl();
  if (ids.length < 2) {
    render([]);
    return;
  }
  try {
    const laptops = await apiFetch(`api/laptops.php?action=compare&ids=${ids.join(',')}`);
    render(laptops);
  } catch (e) {
    elWrap.innerHTML = `<div class="empty-state"><h3>Gagal memuat perbandingan</h3><p>${escapeHtmlSafe(e.message)}</p></div>`;
  }
})();

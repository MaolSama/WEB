/**
 * Helper umum: fetch wrapper, format rupiah, toast notification,
 * dan state Compare Box yang disimpan di sessionStorage
 * (per tab/sesi browser — tidak pakai localStorage permanen).
 */

const MAX_COMPARE = 3;

async function apiFetch(url, options = {}) {
  const res = await fetch(url, {
    headers: { 'Content-Type': 'application/json' },
    ...options,
  });
  const data = await res.json().catch(() => ({}));
  if (!res.ok) {
    throw new Error(data.error || 'Terjadi kesalahan.');
  }
  return data;
}

function formatRupiah(value) {
  if (value === null || value === undefined) return '-';
  return 'Rp' + Number(value).toLocaleString('id-ID');
}

function showToast(message, type = 'info') {
  let stack = document.querySelector('.toast-stack');
  if (!stack) {
    stack = document.createElement('div');
    stack.className = 'toast-stack';
    document.body.appendChild(stack);
  }
  const toast = document.createElement('div');
  toast.className = 'toast' + (type === 'error' ? ' error' : '');
  toast.textContent = message;
  stack.appendChild(toast);
  setTimeout(() => toast.remove(), 3200);
}

/* ---------- Compare Box (sessionStorage) ---------- */
const CompareBox = {
  KEY: 'compare_ids',

  getIds() {
    try {
      return JSON.parse(sessionStorage.getItem(this.KEY)) || [];
    } catch {
      return [];
    }
  },

  setIds(ids) {
    sessionStorage.setItem(this.KEY, JSON.stringify(ids));
  },

  has(id) {
    return this.getIds().includes(id);
  },

  add(id) {
    const ids = this.getIds();
    if (ids.includes(id)) return { ok: true, ids };
    if (ids.length >= MAX_COMPARE) {
      return { ok: false, reason: `Maksimal ${MAX_COMPARE} laptop untuk dibandingkan.`, ids };
    }
    ids.push(id);
    this.setIds(ids);
    return { ok: true, ids };
  },

  remove(id) {
    const ids = this.getIds().filter((x) => x !== id);
    this.setIds(ids);
    return ids;
  },

  clear() {
    this.setIds([]);
  },
};

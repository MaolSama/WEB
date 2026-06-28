<?php
require_once __DIR__ . '/../includes/auth_check.php';
require_admin_page();
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard Admin — CompareDeck</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;700&family=Inter:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
  <header class="topbar">
    <div class="topbar-inner">
      <a href="../index.php" class="brand">Compare<span class="tag">DECK</span></a>
      <nav class="nav-links">
        <a href="../index.php">Katalog</a>
        <span class="user-pill mono" style="opacity:.8;">@<?= htmlspecialchars(current_username()) ?></span>
        <a href="../logout.php" class="btn btn-outline" style="color:#fff;border-color:rgba(255,255,255,0.3);">Keluar</a>
      </nav>
    </div>
  </header>

  <main class="shell">
    <div class="admin-head">
      <div>
        <p class="eyebrow">Admin Dashboard</p>
        <h1>Kelola Data Laptop</h1>
      </div>
      <button class="btn btn-accent" id="addLaptopBtn">+ Tambah Laptop</button>
    </div>

    <div class="hero" style="margin-bottom:16px;padding:14px 18px;">
      <input type="text" id="adminSearch" placeholder="Cari brand atau nama laptop..."
        style="width:100%;border:1px solid var(--line);border-radius:8px;padding:9px 12px;font-family:'IBM Plex Mono',monospace;font-size:0.85rem;">
    </div>

    <div class="admin-table-wrap">
      <table class="admin-table">
        <thead>
          <tr>
            <th>Brand</th><th>Nama</th><th>Harga</th><th>RAM</th><th>Storage</th><th>Rating</th><th>Aksi</th>
          </tr>
        </thead>
        <tbody id="adminTableBody">
          <tr><td colspan="7">Memuat data...</td></tr>
        </tbody>
      </table>
    </div>
  </main>

  <!-- Modal Tambah/Edit Laptop -->
  <div class="modal-overlay hidden" id="laptopModalOverlay">
    <div class="modal">
      <h2 id="laptopModalTitle">Tambah Laptop</h2>
      <p class="modal-sub">Lengkapi data spesifikasi laptop di bawah ini.</p>

      <form id="laptopForm">
        <p class="form-section-title">Identitas & Harga</p>
        <div class="form-grid">
          <div><label for="f_brand">Brand</label><input type="text" id="f_brand" name="brand" required></div>
          <div><label for="f_name">Nama Laptop</label><input type="text" id="f_name" name="name" required></div>
          <div><label for="f_price">Harga (Rp)</label><input type="number" id="f_price" name="price" required></div>
          <div><label for="f_spec_rating">Rating Spek (0-100)</label><input type="number" id="f_spec_rating" name="spec_rating" required></div>
        </div>

        <p class="form-section-title">Performa</p>
        <div class="form-grid">
          <div class="full"><label for="f_processor">Prosesor</label><input type="text" id="f_processor" name="processor" required></div>
          <div class="full"><label for="f_cpu">Core / Thread</label><input type="text" id="f_cpu" name="cpu" required></div>
          <div><label for="f_ram_gb">RAM (GB)</label><input type="number" id="f_ram_gb" name="ram_gb" required></div>
          <div><label for="f_ram_type">Tipe RAM</label><input type="text" id="f_ram_type" name="ram_type" required></div>
          <div><label for="f_storage_gb">Storage (GB)</label><input type="number" id="f_storage_gb" name="storage_gb" required></div>
          <div><label for="f_rom_type">Tipe Storage</label><input type="text" id="f_rom_type" name="rom_type" required></div>
          <div class="full"><label for="f_gpu">GPU</label><input type="text" id="f_gpu" name="gpu" required></div>
        </div>

        <p class="form-section-title">Display & Lainnya</p>
        <div class="form-grid">
          <div><label for="f_display_size">Ukuran Layar (inci)</label><input type="text" id="f_display_size" name="display_size" required></div>
          <div><label for="f_warranty">Garansi (tahun)</label><input type="number" id="f_warranty" name="warranty" required></div>
          <div><label for="f_resolution_width">Resolusi Width</label><input type="number" id="f_resolution_width" name="resolution_width" required></div>
          <div><label for="f_resolution_height">Resolusi Height</label><input type="number" id="f_resolution_height" name="resolution_height" required></div>
          <div class="full"><label for="f_os">Sistem Operasi</label><input type="text" id="f_os" name="os" required></div>
        </div>

        <div class="modal-actions">
          <button type="button" class="btn btn-outline" id="cancelModalBtn">Batal</button>
          <button type="submit" class="btn btn-primary">Simpan</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Modal Konfirmasi Hapus -->
  <div class="modal-overlay hidden" id="deleteOverlay">
    <div class="modal" style="max-width:400px;">
      <h2>Hapus Laptop?</h2>
      <p class="modal-sub">Data yang dihapus tidak bisa dikembalikan.</p>
      <div class="modal-actions">
        <button class="btn btn-outline" id="cancelDeleteBtn">Batal</button>
        <button class="btn btn-danger" id="confirmDeleteBtn" style="background:var(--danger);color:#fff;">Ya, Hapus</button>
      </div>
    </div>
  </div>

  <script src="../assets/js/api.js"></script>
  <script>window.API_BASE = '../api/laptops.php';</script>
  <script src="../assets/js/admin.js"></script>
</body>
</html>

<?php
require_once __DIR__ . '/includes/auth_check.php';
start_session_safe();
$isAdmin = is_admin();
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CompareDeck — Bandingkan Spesifikasi Laptop</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;700&family=Inter:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

  <header class="topbar">
    <div class="topbar-inner">
      <a href="index.php" class="brand">Compare<span class="tag">DECK</span></a>
      <nav class="nav-links">
        <a href="index.php">Katalog</a>
        <?php if ($isAdmin): ?>
          <a href="admin/index.php">Dashboard Admin</a>
          <a href="logout.php" class="btn btn-outline" style="color:#fff;border-color:rgba(255,255,255,0.3);">Keluar</a>
        <?php else: ?>
          <a href="login.php" class="btn btn-accent">Login Admin</a>
        <?php endif; ?>
      </nav>
    </div>
  </header>

  <main class="shell">
    <section class="hero">
      <p class="eyebrow">Spec Sheet Catalogue</p>
      <h1>Bandingkan spesifikasi laptop sebelum membeli.</h1>
      <p>Cari, saring berdasarkan kebutuhan, lalu tambahkan 2–3 laptop ke Compare Box untuk melihat data sheet perbandingan lengkap.</p>

      <div class="toolbar">
        <input type="text" id="searchInput" placeholder="Cari brand atau nama laptop...">
        <select id="kebutuhanFilter">
          <option value="">Semua Kebutuhan</option>
        </select>
        <select id="sortSelect">
          <option value="rating_desc">Rating Spek: Tertinggi</option>
          <option value="price_asc">Harga: Terendah</option>
          <option value="price_desc">Harga: Tertinggi</option>
          <option value="name_asc">Nama: A-Z</option>
        </select>
      </div>
    </section>

    <section id="laptopGrid" class="grid">
      <p class="eyebrow">Memuat data...</p>
    </section>
  </main>

  <div class="compare-bar" id="compareBar">
    <div class="compare-bar-inner">
      <span class="compare-bar-label">COMPARE BOX <span id="compareCount" class="mono">0/3</span></span>
      <div class="compare-chips" id="compareChips"></div>
      <button class="btn btn-accent" id="compareGoBtn" disabled>Compare Now &rarr;</button>
    </div>
  </div>

  <script src="assets/js/api.js"></script>
  <script src="assets/js/home.js"></script>
</body>
</html>

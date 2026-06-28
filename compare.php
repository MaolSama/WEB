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
<title>Perbandingan Laptop — CompareDeck</title>
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
    <div class="compare-head">
      <div>
        <p class="eyebrow">Spec Sheet Comparison</p>
        <h1>Hasil Perbandingan Laptop</h1>
      </div>
      <a href="index.php" class="btn btn-outline">&larr; Tambah/Ubah Pilihan</a>
    </div>

    <div id="compareWrap">
      <p class="eyebrow">Memuat perbandingan...</p>
    </div>
  </main>

  <script src="assets/js/api.js"></script>
  <script src="assets/js/compare.js"></script>
</body>
</html>

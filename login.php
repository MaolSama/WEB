<?php
require_once __DIR__ . '/includes/auth_check.php';
start_session_safe();
if (is_admin()) {
    header('Location: admin/index.php');
    exit;
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Admin — CompareDeck</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;700&family=Inter:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="auth-body">
  <main class="auth-card">
    <p class="eyebrow">Compare<span style="opacity:.6">DECK</span></p>
    <h1>Login Admin</h1>
    <p class="auth-sub">Khusus admin, untuk mengelola data laptop.</p>

    <div id="loginError" class="alert alert-error" style="display:none;"></div>

    <form id="loginForm" class="auth-form">
      <label for="username">Username</label>
      <input type="text" id="username" name="username" required autocomplete="username">

      <label for="password">Password</label>
      <input type="password" id="password" name="password" required autocomplete="current-password">

      <button type="submit" class="btn btn-primary btn-block">Masuk</button>
    </form>

    <p class="auth-foot"><a href="index.php">&larr; Kembali ke Katalog</a></p>
  </main>

  <script src="assets/js/api.js"></script>
  <script src="assets/js/login.js"></script>
  <script>
    // tampilkan error inline (override sederhana dari login.js textContent target)
    const errBox = document.getElementById('loginError');
    const observer = new MutationObserver(() => {
      errBox.style.display = errBox.textContent ? 'block' : 'none';
    });
    observer.observe(errBox, { childList: true, characterData: true, subtree: true });
  </script>
</body>
</html>

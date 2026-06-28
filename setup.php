<?php
/**
 * SETUP SEKALI JALAN
 * Jalankan file ini di browser (http://localhost/compare-deck/setup.php)
 * SATU KALI setelah import database, untuk membuat akun admin pertama.
 * Setelah berhasil, sebaiknya HAPUS file ini dari server.
 */

require_once __DIR__ . '/config/database.php';

$message = '';
$done = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = trim($_POST['password'] ?? '');

    if ($username === '' || $password === '') {
        $message = 'Username dan password wajib diisi.';
    } elseif (strlen($password) < 6) {
        $message = 'Password minimal 6 karakter.';
    } else {
        $pdo = getConnection();
        $check = $pdo->prepare('SELECT COUNT(*) FROM users WHERE username = ?');
        $check->execute([$username]);

        if ($check->fetchColumn() > 0) {
            $message = 'Username sudah dipakai. Coba username lain.';
        } else {
            $hash = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $pdo->prepare('INSERT INTO users (username, password, role) VALUES (?, ?, ?)');
            $stmt->execute([$username, $hash, 'admin']);
            $done = true;
            $message = "Akun admin '$username' berhasil dibuat. Silakan hapus file setup.php lalu login.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<title>Setup Admin - CompareDeck</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="auth-body">
  <main class="auth-card">
    <p class="eyebrow">Setup &mdash; sekali jalan</p>
    <h1>Buat Akun Admin</h1>
    <p class="auth-sub">Form ini untuk membuat akun admin pertama. Hapus file <code>setup.php</code> setelah selesai.</p>

    <?php if ($message): ?>
      <div class="alert <?= $done ? 'alert-success' : 'alert-error' ?>"><?= htmlspecialchars($message) ?></div>
    <?php endif; ?>

    <?php if (!$done): ?>
    <form method="POST" class="auth-form">
      <label for="username">Username</label>
      <input type="text" id="username" name="username" required autocomplete="off">

      <label for="password">Password</label>
      <input type="password" id="password" name="password" required minlength="6">

      <button type="submit" class="btn btn-accent btn-block">Buat Akun Admin</button>
    </form>
    <?php else: ?>
      <a class="btn btn-primary btn-block" href="login.php">Lanjut ke Login</a>
    <?php endif; ?>
  </main>
</body>
</html>

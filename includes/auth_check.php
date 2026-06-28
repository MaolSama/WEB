<?php
/**
 * Helper session & auth.
 * Project ini hanya punya satu role: admin. User biasa (belum login)
 * tetap bisa browsing & compare, tapi CRUD laptop khusus admin.
 */

function start_session_safe(): void
{
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
}

function is_logged_in(): bool
{
    start_session_safe();
    return isset($_SESSION['user_id']) && isset($_SESSION['role']);
}

function is_admin(): bool
{
    start_session_safe();
    return is_logged_in() && $_SESSION['role'] === 'admin';
}

function current_username(): ?string
{
    start_session_safe();
    return $_SESSION['username'] ?? null;
}

/** Dipakai di api/*.php — hentikan request dengan JSON 401 jika bukan admin */
function require_admin_api(): void
{
    if (!is_admin()) {
        http_response_code(401);
        header('Content-Type: application/json');
        echo json_encode(['error' => 'Akses ditolak. Khusus admin.']);
        exit;
    }
}

/** Dipakai di halaman .php — redirect ke login.php jika bukan admin */
function require_admin_page(): void
{
    if (!is_admin()) {
        header('Location: /login.php?redirect=admin');
        exit;
    }
}

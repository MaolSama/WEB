<?php
$file = __DIR__ . $_SERVER['REQUEST_URI'];

// Sajikan file statis (CSS, JS, gambar) langsung
if (is_file($file)) {
    $ext = pathinfo($file, PATHINFO_EXTENSION);
    $mime = [
        'css' => 'text/css',
        'js'  => 'application/javascript',
        'png' => 'image/png',
        'jpg' => 'image/jpeg',
        'svg' => 'image/svg+xml',
    ];
    if (isset($mime[$ext])) {
        header('Content-Type: ' . $mime[$ext]);
        readfile($file);
        exit;
    }
    return false; // Biarkan PHP built-in server yang handle
}

// Semua request lain arahkan ke index.php
include __DIR__ . '/index.php';

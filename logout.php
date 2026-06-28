<?php
require_once __DIR__ . '/includes/auth_check.php';
start_session_safe();
$_SESSION = [];
session_destroy();
header('Location: index.php');
exit;

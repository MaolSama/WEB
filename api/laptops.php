<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../includes/auth_check.php';

header('Content-Type: application/json');
start_session_safe();

$pdo = getConnection();
$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? 'list';

const MAX_COMPARE = 3;

function laptop_fields(): array
{
    return [
        'brand', 'name', 'price', 'spec_rating', 'processor', 'cpu',
        'ram_gb', 'ram_type', 'storage_gb', 'rom_type', 'gpu',
        'display_size', 'resolution_width', 'resolution_height', 'warranty', 'os',
    ];
}

function read_json_body(): array
{
    return json_decode(file_get_contents('php://input'), true) ?? [];
}

// ---------------------------------------------------------------
// GET: list (dengan search/filter/sort), get, compare, kebutuhan
// ---------------------------------------------------------------
if ($method === 'GET' && $action === 'list') {
    $q = trim($_GET['q'] ?? '');
    $kebutuhanId = $_GET['kebutuhan_id'] ?? '';
    $sort = $_GET['sort'] ?? '';

    $sql = 'SELECT * FROM laptop WHERE 1=1';
    $params = [];

    if ($q !== '') {
        $sql .= ' AND (brand LIKE ? OR name LIKE ?)';
        $params[] = "%$q%";
        $params[] = "%$q%";
    }

    if ($kebutuhanId !== '') {
        $ruleStmt = $pdo->prepare('SELECT * FROM rule_kebutuhan WHERE kebutuhan_id = ?');
        $ruleStmt->execute([$kebutuhanId]);
        $rule = $ruleStmt->fetch();

        if ($rule) {
            $sql .= ' AND ram_gb >= ? AND storage_gb >= ?';
            $params[] = (int) $rule['min_ram'];
            $params[] = (int) $rule['min_storage'];
            if ((int) $rule['gpu_required'] === 1) {
                $sql .= " AND gpu NOT LIKE '%Integrated%' AND gpu NOT LIKE '%Intel Iris%' AND gpu NOT LIKE '%Intel UHD%' AND gpu NOT LIKE '%Intel Graphics%' AND gpu NOT LIKE '%AMD Radeon AMD%' AND gpu NOT LIKE '%AMD Integrated%'";
            }
        }
    }

    $sortMap = [
        'price_asc' => 'price ASC',
        'price_desc' => 'price DESC',
        'rating_desc' => 'spec_rating DESC',
        'name_asc' => 'name ASC',
    ];
    $sql .= ' ORDER BY ' . ($sortMap[$sort] ?? 'spec_rating DESC');

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    echo json_encode($stmt->fetchAll());
    exit;
}

if ($method === 'GET' && $action === 'get') {
    $id = (int) ($_GET['id'] ?? 0);
    $stmt = $pdo->prepare('SELECT * FROM laptop WHERE laptop_id = ?');
    $stmt->execute([$id]);
    $row = $stmt->fetch();

    if (!$row) {
        http_response_code(404);
        echo json_encode(['error' => 'Laptop tidak ditemukan.']);
        exit;
    }

    echo json_encode($row);
    exit;
}

if ($method === 'GET' && $action === 'compare') {
    $idsParam = $_GET['ids'] ?? '';
    $ids = array_filter(array_map('intval', explode(',', $idsParam)));

    if (count($ids) < 2) {
        http_response_code(422);
        echo json_encode(['error' => 'Pilih minimal 2 laptop untuk dibandingkan.']);
        exit;
    }

    if (count($ids) > MAX_COMPARE) {
        http_response_code(422);
        echo json_encode(['error' => 'Maksimal ' . MAX_COMPARE . ' laptop yang bisa dibandingkan.']);
        exit;
    }

    $placeholders = implode(',', array_fill(0, count($ids), '?'));
    $stmt = $pdo->prepare("SELECT * FROM laptop WHERE laptop_id IN ($placeholders)");
    $stmt->execute($ids);
    $rows = $stmt->fetchAll();

    // urutkan sesuai urutan ids yang diminta (supaya konsisten dengan compare box)
    $byId = [];
    foreach ($rows as $row) {
        $byId[$row['laptop_id']] = $row;
    }
    $ordered = [];
    foreach ($ids as $id) {
        if (isset($byId[$id])) {
            $ordered[] = $byId[$id];
        }
    }

    echo json_encode($ordered);
    exit;
}

if ($method === 'GET' && $action === 'kebutuhan') {
    $stmt = $pdo->query('SELECT * FROM kebutuhan ORDER BY kebutuhan_id');
    echo json_encode($stmt->fetchAll());
    exit;
}

// ---------------------------------------------------------------
// POST: create (admin only)
// ---------------------------------------------------------------
if ($method === 'POST' && $action === 'create') {
    require_admin_api();
    $body = read_json_body();

    $fields = laptop_fields();
    $columns = [];
    $placeholders = [];
    $values = [];

    foreach ($fields as $field) {
        if (!array_key_exists($field, $body)) {
            http_response_code(422);
            echo json_encode(['error' => "Field '$field' wajib diisi."]);
            exit;
        }
        $columns[] = $field;
        $placeholders[] = '?';
        $values[] = $body[$field];
    }

    $sql = 'INSERT INTO laptop (' . implode(',', $columns) . ') VALUES (' . implode(',', $placeholders) . ')';
    $stmt = $pdo->prepare($sql);
    $stmt->execute($values);

    echo json_encode(['success' => true, 'laptop_id' => $pdo->lastInsertId()]);
    exit;
}

// ---------------------------------------------------------------
// PUT: update (admin only)
// ---------------------------------------------------------------
if ($method === 'PUT' && $action === 'update') {
    require_admin_api();
    $body = read_json_body();
    $id = (int) ($body['laptop_id'] ?? 0);

    if (!$id) {
        http_response_code(422);
        echo json_encode(['error' => 'laptop_id wajib diisi.']);
        exit;
    }

    $fields = laptop_fields();
    $sets = [];
    $values = [];

    foreach ($fields as $field) {
        if (array_key_exists($field, $body)) {
            $sets[] = "$field = ?";
            $values[] = $body[$field];
        }
    }

    if (empty($sets)) {
        http_response_code(422);
        echo json_encode(['error' => 'Tidak ada data untuk diupdate.']);
        exit;
    }

    $values[] = $id;
    $sql = 'UPDATE laptop SET ' . implode(',', $sets) . ' WHERE laptop_id = ?';
    $stmt = $pdo->prepare($sql);
    $stmt->execute($values);

    echo json_encode(['success' => true]);
    exit;
}

// ---------------------------------------------------------------
// DELETE: delete (admin only)
// ---------------------------------------------------------------
if ($method === 'DELETE' && $action === 'delete') {
    require_admin_api();
    $id = (int) ($_GET['id'] ?? 0);

    if (!$id) {
        http_response_code(422);
        echo json_encode(['error' => 'id wajib diisi.']);
        exit;
    }

    $stmt = $pdo->prepare('DELETE FROM laptop WHERE laptop_id = ?');
    $stmt->execute([$id]);

    echo json_encode(['success' => true]);
    exit;
}

http_response_code(404);
echo json_encode(['error' => 'Aksi tidak ditemukan.']);

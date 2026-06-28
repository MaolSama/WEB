const form = document.getElementById('loginForm');
const elError = document.getElementById('loginError');

form.addEventListener('submit', async (e) => {
  e.preventDefault();
  elError.textContent = '';

  const username = document.getElementById('username').value.trim();
  const password = document.getElementById('password').value;

  try {
    await apiFetch('api/auth.php?action=login', {
      method: 'POST',
      body: JSON.stringify({ username, password }),
    });
    window.location.href = 'admin/index.php';
  } catch (err) {
    elError.textContent = err.message;
  }
});

// script.js

document.addEventListener('DOMContentLoaded', function () {
    const togglePassword = document.querySelector('.toggle-password');
    const passwordInput = document.querySelector('input[type="password"]');

    togglePassword.addEventListener('click', () => {
        const isPassword = passwordInput.type === 'password';
        passwordInput.type = isPassword ? 'text' : 'password';
        togglePassword.textContent = isPassword ? '🙈' : '👁️';
    });
});

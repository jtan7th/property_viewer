function toggleMobileMenu() {
    const mobileMenu = document.getElementById('mobileMenu');
    const openIcon = document.getElementById('openIcon');
    const closeIcon = document.getElementById('closeIcon');
    
    mobileMenu.classList.toggle('hidden');
    openIcon.classList.toggle('hidden');
    closeIcon.classList.toggle('hidden');
  }
  
  // Listen for both initial page load and Turbo navigation
  document.addEventListener('turbo:load', attachMobileMenuListener);
  document.addEventListener('DOMContentLoaded', attachMobileMenuListener);
  
  function attachMobileMenuListener() {
    const menuButton = document.querySelector('[onclick="toggleMobileMenu()"]');
    if (menuButton) {
      // Remove existing listener to prevent duplicates
      menuButton.removeEventListener('click', toggleMobileMenu);
      // Add new listener
      menuButton.addEventListener('click', toggleMobileMenu);
    }
  }
function toggleMobileMenu() {
    const mobileMenu = document.getElementById('mobileMenu');
    const openIcon = document.getElementById('openIcon');
    const closeIcon = document.getElementById('closeIcon');
    
    mobileMenu.classList.toggle('hidden');
    openIcon.classList.toggle('hidden');
    closeIcon.classList.toggle('hidden');
  }
  
  // Add event listener when the DOM is loaded
  document.addEventListener('DOMContentLoaded', function() {
    const menuButton = document.querySelector('[onclick="toggleMobileMenu()"]');
    if (menuButton) {
      menuButton.addEventListener('click', toggleMobileMenu);
    }
  });
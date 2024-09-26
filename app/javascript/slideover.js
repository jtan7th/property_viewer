function toggleSlideover(){
    document.getElementById('slideover-container').classList.toggle('invisible');
    document.getElementById('slideover-bg').classList.toggle('opacity-0');
    document.getElementById('slideover').classList.toggle('translate-x-full');
}

// Make the function globally available
window.toggleSlideover = toggleSlideover;
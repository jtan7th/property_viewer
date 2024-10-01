let initializedCarousels = new Set();

// Function to set up and control the carousel
function initializeCarousel(carousel) {
  if (initializedCarousels.has(carousel)) {
    console.log('Carousel already initialized, skipping');
    return;
  }

  const images = carousel.querySelectorAll('.property-image');
  let currentIndex = 0;

  console.log(`New carousel initialized. Images found:`, images.length);

  function showImage(index) {
    images.forEach((img, i) => {
      img.classList.toggle('hidden', i !== index);
    });
  }

  function nextImage() {
    console.log('Next image');
    currentIndex = (currentIndex + 1) % images.length;
    showImage(currentIndex);
  }

  function prevImage() {
    console.log('Previous image');
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    showImage(currentIndex);
  }

  // Use event delegation for button clicks
  carousel.addEventListener('click', function(event) {
    if (event.target.classList.contains('next')) {
      nextImage();
    } else if (event.target.classList.contains('prev')) {
      prevImage();
    }
  });

  // Add keyboard navigation
  function handleKeydown(event) {
    if (event.key === 'ArrowRight') {
      nextImage();
    } else if (event.key === 'ArrowLeft') {
      prevImage();
    }
  }

  // Add the keydown event listener when the carousel is visible
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        document.addEventListener('keydown', handleKeydown);
      } else {
        document.removeEventListener('keydown', handleKeydown);
      }
    });
  });

  observer.observe(carousel);

  initializedCarousels.add(carousel);
  console.log('Carousel initialized');
}

// Function to observe DOM changes and initialize the carousel when it's available
function observeDOM() {
  console.log('observeDOM function called');
  const observer = new MutationObserver((mutations) => {
    mutations.forEach(mutation => {
      if (mutation.type === 'childList') {
        mutation.addedNodes.forEach(node => {
          if (node.nodeType === Node.ELEMENT_NODE) {
            const carousel = node.querySelector('.image-container.carousel');
            if (carousel) {
              console.log('New carousel found in DOM');
              initializeCarousel(carousel);
            }
          }
        });
      }
    });
  });

  observer.observe(document.body, {
    childList: true,
    subtree: true
  });
}

// Initialize existing carousels
function initializeExistingCarousels() {
  document.querySelectorAll('.image-container.carousel').forEach(initializeCarousel);
}

// Add an event listener for Turbo's page load event
document.addEventListener('turbo:load', () => {
  observeDOM();
  initializeExistingCarousels();
});

// Also add an event listener for standard DOM content loaded event (for compatibility)
document.addEventListener('DOMContentLoaded', () => {
  observeDOM();
  initializeExistingCarousels();
});
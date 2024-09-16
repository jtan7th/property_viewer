// Function to set up and control the carousel
function initializeCarousel() {
  // Get the carousel container element
  const carousel = document.getElementById('carousel');
  // If carousel element doesn't exist, exit the function
  if (!carousel) return;

  // Get all image elements within the carousel
  const images = carousel.querySelectorAll('.property-image');
  // Get the previous and next button elements
  const prevButton = document.getElementById('prevButton');
  const nextButton = document.getElementById('nextButton');
  // Initialize the index of the currently displayed image
  let currentIndex = 0;

  // Function to display the image at the given index
  function showImage(index) {
    // Loop through all images
    images.forEach((img, i) => {
      // Toggle the 'hidden' class based on whether the image should be shown
      img.classList.toggle('hidden', i !== index);
    });
  }

  // Function to show the next image
  function nextImage() {
    // Increment the index, wrapping around to 0 if at the end
    currentIndex = (currentIndex + 1) % images.length;
    // Show the image at the new index
    showImage(currentIndex);
  }

  // Function to show the previous image
  function prevImage() {
    // Decrement the index, wrapping around to the last image if at the beginning
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    // Show the image at the new index
    showImage(currentIndex);
  }

  // If the next button exists, add a click event listener to it
  if (nextButton) {
    nextButton.addEventListener('click', nextImage);
  }

  // If the previous button exists, add a click event listener to it
  if (prevButton) {
    prevButton.addEventListener('click', prevImage);
  }

  // Add event listener for keydown events on the document
  document.addEventListener('keydown', function(event) {
    // Check if the pressed key is the left arrow key
    if (event.key === 'ArrowLeft') {
      // If so, show the previous image
      prevImage();
    // Check if the pressed key is the right arrow key
    } else if (event.key === 'ArrowRight') {
      // If so, show the next image
      nextImage();
    }
  });
}

// Function to observe DOM changes and initialize the carousel when it's available
function observeDOM() {
  // Create a new MutationObserver
  const observer = new MutationObserver((mutations) => {
    // Check if the carousel element exists in the DOM
    if (document.getElementById('carousel')) {
      // If it does, stop observing (to avoid unnecessary processing)
      observer.disconnect();
      // Initialize the carousel
      initializeCarousel();
    }
  });

  // Start observing the document body for child list changes, including in subtrees
  observer.observe(document.body, {
    childList: true,
    subtree: true
  });
}

// Add an event listener for Turbo's page load event
document.addEventListener('turbo:load', observeDOM);
// Also add an event listener for standard DOM content loaded event (for compatibility)
document.addEventListener('DOMContentLoaded', observeDOM);
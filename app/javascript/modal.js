document.addEventListener('DOMContentLoaded', function() {
  
  let currentFilterUrl = null;

  const captureFilterUrl = () => {
    document.addEventListener('turbo:before-fetch-request', (event) => {
      const url = new URL(event.detail.url);
      
      // Check if the URL contains any query parameters
      if (url.search) {
        currentFilterUrl = url.toString();
      }
    });
  };

  captureFilterUrl();
  
  // Function to open the modal with transition
  const openModal = (modal) => {
    modal.classList.remove('hidden');
    modal.classList.add('modal-enter');
    document.body.style.overflow = 'hidden'; // Prevent scrolling when modal is open
    
    // Force a reflow before adding the 'modal-enter-active' class
    modal.offsetWidth;
    
    modal.classList.add('modal-enter-active');
    
    setTimeout(() => {
      modal.classList.remove('modal-enter', 'modal-enter-active');
    }, 300); // This should match the transition duration in your CSS
  };

  // Function to close the modal with transition
  const closeModal = (modal) => {
    modal.classList.add('modal-exit');
    document.body.style.overflow = ''; // Re-enable scrolling
    
    // Force a reflow before adding the 'modal-exit-active' class
    modal.offsetWidth;
    
    modal.classList.add('modal-exit-active');
    
    setTimeout(() => {
      modal.classList.remove('modal-exit', 'modal-exit-active');
      modal.classList.add('hidden');
      
      // Navigate using the stored filter URL or fall back to properties_path
      const navigateUrl = currentFilterUrl || '/properties';
      Turbo.visit(navigateUrl);
    }, 300); // This should match the transition duration in your CSS
  };

  // Function to handle clicks
  const handleClick = (event) => {
    const modal = document.getElementById('modal');
    if (!modal) return;

    const modalContent = document.getElementById('modal-content');
    if (!modalContent) return;

    // Check if the click is outside the modal content
    if (!modalContent.contains(event.target) && modal.contains(event.target)) {
      // Close the modal
      closeModal(modal);
      
      // Prevent default behavior
      event.preventDefault();
    }
  };

  // Add click event listener to the document
  document.addEventListener('click', handleClick);

  // Function to start observing the DOM for the modal
  const observeModal = () => {
    const observer = new MutationObserver((mutations) => {
      for (let mutation of mutations) {
        if (mutation.type === 'childList') {
          const modal = document.getElementById('modal');
          if (modal) {
            const modalContent = document.getElementById('modal-content');
            if (modalContent) {
              observer.disconnect();
              openModal(modal); // Open the modal with transition when it's added to the DOM
              return;
            }
          }
        }
      }
    });

    observer.observe(document.body, {
      childList: true,
      subtree: true
    });
  };

  // Start observing for the modal
  observeModal();

  // As a fallback, also listen for Turbo events
  document.addEventListener('turbo:load', observeModal);
});
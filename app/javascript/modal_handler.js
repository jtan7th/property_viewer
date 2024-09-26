//filter modal handler

export function setupModalHandler() {
    const filterModal = document.getElementById('filter-modal');
    const filterLink = document.querySelector('a[href*="filter_modal"]');
    let lastFormData = null;

    if (filterLink) {
      filterLink.addEventListener('click', (event) => {
        event.preventDefault();
        openModal();
      });
    }

    if (filterModal) {
      filterModal.addEventListener('click', (event) => {
        if (event.target === filterModal) {
          closeModal();
        }
      });
    }

    document.addEventListener("turbo:submit-end", (event) => {
      if (filterModal) {
        closeModal();
        lastFormData = new FormData(event.target);
      }
    });

    function openModal() {
      filterModal.classList.remove('hidden');
      filterModal.classList.add('modal-enter');
      document.body.style.overflow = 'hidden'; // Prevent scrolling when modal is open
      
      // Force a reflow before adding the 'modal-enter-active' class
      filterModal.offsetWidth;
      
      filterModal.classList.add('modal-enter-active');
      
      setTimeout(() => {
        filterModal.classList.remove('modal-enter', 'modal-enter-active');
      }, 300); // This should match the transition duration in your CSS
          }

    function closeModal() {
      filterModal.classList.add('modal-exit');
      document.body.style.overflow = ''; // Re-enable scrolling
      
      // Force a reflow before adding the 'modal-exit-active' class
      filterModal.offsetWidth;
      
      filterModal.classList.add('modal-exit-active');
      
      setTimeout(() => {
        filterModal.classList.remove('modal-exit', 'modal-exit-active');
        filterModal.classList.add('hidden');
      }, 300); // This should match the transition duration in your CSS
    }

    // New code for closing modal when clicking outside
    const handleClick = (event) => {
      const filterModalContent = filterModal.querySelector('#filter-modal-content');
      if (!filterModalContent) return;

      // Check if the click is outside the modal content
      if (!filterModalContent.contains(event.target) && filterModal.contains(event.target)) {
        closeModal();
        event.preventDefault();
      }
    };

    // Add click event listener to the document
    document.addEventListener('click', handleClick);

    // Function to start observing the DOM for the filter modal
    const observeFilterModal = () => {
      const observer = new MutationObserver((mutations) => {
        for (let mutation of mutations) {
          if (mutation.type === 'childList') {
            if (filterModal) {
              const filterModalContent = filterModal.querySelector('#filter-modal-content');
              if (filterModalContent) {
                observer.disconnect();
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

    // Start observing for the filter modal
    observeFilterModal();

    // As a fallback, also listen for Turbo events
    document.addEventListener('turbo:load', observeFilterModal);
  }
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
      filterModal.style.display = 'block';
      resetForm();
    }

    function closeModal() {
      filterModal.classList.add('hidden');
      filterModal.style.display = 'none';
    }

    function resetForm() {
      const form = filterModal.querySelector('form');
      if (form) {
        if (lastFormData) {
          // Populate form with last submitted data
          lastFormData.forEach((value, key) => {
            const field = form.elements[key];
            if (field) {
              if (field.type === 'checkbox' || field.type === 'radio') {
                field.checked = (field.value === value);
              } else {
                field.value = value;
              }
            }
          });
        } else {
          // Reset to default values if no previous submission
          form.reset();
        }
      }
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
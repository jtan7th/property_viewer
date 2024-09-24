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
      console.log("Form submitted, turbo:submit-end event fired");
      console.log("Time since page load:", Date.now() - window.pageLoadTime, "ms");
      
      if (filterModal) {
        console.log("Filter modal found, hiding it");
        closeModal();
        // Store the form data for potential reuse
        lastFormData = new FormData(event.target);
      } else {
        console.log("Filter modal not found");
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
  }
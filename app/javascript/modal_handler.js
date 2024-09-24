export function setupModalHandler() {
    const filterModal = document.getElementById('filter-modal');
    const filterLink = document.querySelector('a[href*="filter_modal"]');
    
    if (filterLink) {
      filterLink.addEventListener('click', (event) => {
        event.preventDefault();
        filterModal.classList.remove('hidden');
      });
    }
  
    if (filterModal) {
      filterModal.addEventListener('click', (event) => {
        if (event.target === filterModal) {
          filterModal.classList.add('hidden');
        }
      });
    }
  
    document.addEventListener("turbo:submit-end", (event) => {
      console.log("Form submitted, turbo:submit-end event fired");
      if (filterModal) {
        console.log("Filter modal found, hiding it");
        filterModal.classList.add("hidden");
        filterModal.style.display = "none";  // Force hide the modal
      } else {
        console.log("Filter modal not found");
      }
    });
  }
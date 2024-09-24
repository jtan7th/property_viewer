document.addEventListener('DOMContentLoaded', function() {
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

  // Function to close the modal
  const closeModal = (modal) => {
    modal.classList.add('hidden');
    // Navigate to properties_path using Turbo
    const propertiesPath = '/properties'; // Adjust this if your path is different
    Turbo.visit(propertiesPath);
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
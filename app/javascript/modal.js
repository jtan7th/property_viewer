// document.addEventListener('DOMContentLoaded', function() {
  
//   let currentFilterUrl = null;
//   let lastFormData = null;

//   const captureFilterUrl = () => {
//     document.addEventListener('turbo:before-fetch-request', (event) => {
//       const url = new URL(event.detail.url);
      
//       // Check if the URL contains any query parameters
//       if (url.search) {
//         currentFilterUrl = url.toString();
//       }
//     });
//   };

//   captureFilterUrl();
  
//   // Function to open the modal with transition
//   const openModal = (modal) => {
//     modal.classList.remove('hidden');
//     modal.classList.add('modal-enter');
//     document.body.style.overflow = 'hidden'; // Prevent scrolling when modal is open
    
//     // Force a reflow before adding the 'modal-enter-active' class
//     modal.offsetWidth;
    
//     modal.classList.add('modal-enter-active');
    
//     setTimeout(() => {
//       modal.classList.remove('modal-enter', 'modal-enter-active');
//     }, 300); // This should match the transition duration in your CSS
//   };

//   // Modified closeModal function
//   const closeModal = (modal) => {
//     modal.classList.add('modal-exit');
//     document.body.style.overflow = ''; // Re-enable scrolling
    
//     // Force a reflow before adding the 'modal-exit-active' class
//     modal.offsetWidth;
    
//     modal.classList.add('modal-exit-active');
    
//     setTimeout(() => {
//       modal.classList.remove('modal-exit', 'modal-exit-active');
//       modal.classList.add('hidden');
      
//       // Clear the modal content
//       const modalContent = document.getElementById('modal-content');
//       if (modalContent) {
//         modalContent.innerHTML = '';
//       }

//       // // Update the URL without causing a page reload
//       // if (currentFilterUrl) {
//       //   history.pushState({}, '', currentFilterUrl);
//       //   // Manually trigger a Turbo visit to the properties frame
//       //   Turbo.visit(currentFilterUrl, { frame: 'properties' });
//       // }

//       // Reset the currentFilterUrl
//       currentFilterUrl = null;
//     }, 300); // This should match the transition duration in your CSS
//   };

//   // Function to handle clicks
//   const handleClick = (event) => {
//     const modal = document.getElementById('modal');
//     if (!modal) return;

//     const modalContent = document.getElementById('modal-content');
//     if (!modalContent) return;

//     // Check if the click is outside the modal content
//     if (!modalContent.contains(event.target) && modal.contains(event.target)) {
//       // Close the modal
//       closeModal(modal);
      
//       // Prevent default behavior
//       event.preventDefault();
//     }
//   };

//   // Add click event listener to the document
//   document.addEventListener('click', handleClick);

//   // Function to start observing the DOM for the modal
//   const observeModal = () => {
//     const observer = new MutationObserver((mutations) => {
//       for (let mutation of mutations) {
//         if (mutation.type === 'childList') {
//           const modal = document.getElementById('modal');
//           if (modal) {
//             const modalContent = document.getElementById('modal-content');
//             if (modalContent && modalContent.children.length > 0) {
//               observer.disconnect();
//               openModal(modal); // Open the modal with transition when it's added to the DOM
//               return;
//             }
//           }
//         }
//       }
//     });

//     observer.observe(document.body, {
//       childList: true,
//       subtree: true
//     });
//   };

//   // Start observing for the modal
//   observeModal();

//   // New event listener for form submissions
//   document.addEventListener("turbo:submit-end", (event) => {
//     const modal = document.getElementById('modal');
//     if (modal && !modal.classList.contains('hidden')) {
//       closeModal(modal);
//       lastFormData = new FormData(event.target);
//     }
//   });

//   // As a fallback, also listen for Turbo events
//   document.addEventListener('turbo:load', observeModal);

//   // New event listener for frame load
//   document.addEventListener('turbo:frame-load', (event) => {
//     if (event.target.id === 'modal') {
//       const modal = document.getElementById('modal');
//       if (modal) {
//         openModal(modal);
//       }
//     }
//   });
  
// });

function toggleModal(){
  document.getElementById('modal-container').classList.toggle('invisible');
  document.getElementById('modal-bg').classList.toggle('opacity-0');
  document.getElementById('modalxyz').classList.toggle('visible');
}

// Make the function globally available
window.toggleModal = toggleModal;
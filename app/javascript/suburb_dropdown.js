document.addEventListener('DOMContentLoaded', function() {
    const dropdownButton = document.getElementById('suburb-dropdown-button');
    const dropdown = document.getElementById('suburb-dropdown');
    const checkboxes = document.querySelectorAll('.suburb-checkbox');
    const checks = document.querySelectorAll('.suburb-check');
  
    dropdownButton.addEventListener('click', function() {
      dropdown.classList.toggle('hidden');
    });
  
    checkboxes.forEach((checkbox, index) => {
      checkbox.addEventListener('change', function() {
        if (this.checked) {
          checks[index].classList.remove('hidden');
        } else {
          checks[index].classList.add('hidden');
        }
        updateSelectedSuburbs();
      });
    });
  
    function updateSelectedSuburbs() {
      const selectedSuburbs = Array.from(checkboxes)
        .filter(cb => cb.checked)
        .map(cb => cb.value);
      
      dropdownButton.querySelector('span').textContent = 
        selectedSuburbs.length > 0 ? selectedSuburbs.join(', ') : 'Select suburbs';
    }
  });
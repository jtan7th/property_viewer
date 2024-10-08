document.addEventListener('DOMContentLoaded', function() {
    function initializeDiscreteRangeSlider(options) {
      const inputLeft = document.getElementById(options.inputLeftId);
      const inputRight = document.getElementById(options.inputRightId);
      const sliderRange = document.getElementById(options.sliderRangeId);
      const titleMin = document.getElementById(options.titleMinId);
      const titleMax = document.getElementById(options.titleMaxId);
      const hiddenMinInput = document.getElementById(options.hiddenMinInputId);
      const hiddenMaxInput = document.getElementById(options.hiddenMaxInputId);
      const dotLeft = document.getElementById(options.dotLeftId);
      const dotRight = document.getElementById(options.dotRightId);

      const values = options.values;
      const max = values.length - 1;

      function setLeftValue() {
        let index = parseInt(this.value);
        let rightIndex = parseInt(inputRight.value);
        
        index = Math.min(index, rightIndex);
        this.value = index;
        
        const percent = (index / max) * 100;
        sliderRange.style.left = percent + '%';
        sliderRange.style.width = (rightIndex - index) / max * 100 + '%';
        titleMin.innerText = values[index];
        if (hiddenMinInput) hiddenMinInput.value = values[index];
        if (dotLeft) dotLeft.style.left = percent + '%';
        if (this.form) submitForm(this.form);
      }

      function setRightValue() {
        let index = parseInt(this.value);
        let leftIndex = parseInt(inputLeft.value);
        
        index = Math.max(index, leftIndex);
        this.value = index;
        
        const percent = ((max - index) / max) * 100;
        sliderRange.style.right = percent + '%';
        sliderRange.style.width = (index - leftIndex) / max * 100 + '%';
        titleMax.innerText = values[index];
        if (hiddenMaxInput) hiddenMaxInput.value = values[index];
        if (dotRight) dotRight.style.right = percent + '%';
        if (this.form) submitForm(this.form);
      }

      function submitForm(form) {
        clearTimeout(window.submitTimer);
        window.submitTimer = setTimeout(() => {
          form.requestSubmit();
        }, 50);  // Adjust this delay as needed
      }

      inputLeft.addEventListener('input', setLeftValue);
      inputRight.addEventListener('input', setRightValue);

      // Modified function to create pips, excluding min and max values
      function createPips() {
        const pipsContainer = document.createElement('div');
        pipsContainer.className = 'pips-container';
        pipsContainer.style.position = 'absolute';
        pipsContainer.style.width = '100%';
        pipsContainer.style.height = '10px';
        pipsContainer.style.top = '15px';  // Adjust this value to position the pips vertically

        // Start from 1 and end at values.length - 2 to exclude min and max
        for (let i = 1; i < values.length - 1; i++) {
          const pip = document.createElement('div');
          pip.className = 'pip';
          pip.style.position = 'absolute';
          pip.style.left = `${(i / max) * 100}%`;
          pip.style.width = '1px';
          pip.style.height = '5px';
          pip.style.backgroundColor = 'rgba(0, 0, 0, 0.2)';  // Soft grey color
          pipsContainer.appendChild(pip);
        }

        sliderRange.parentNode.appendChild(pipsContainer);
      }

      // Call createPips after initializing the slider
      createPips();

      // Initialize the slider
      setLeftValue.call(inputLeft);
      setRightValue.call(inputRight);
    }

    // Initialize the bedroom count slider
    const bedroomInputLeft = document.getElementById('bedroom-input-left');
    const bedroomInputRight = document.getElementById('bedroom-input-right');

    if (bedroomInputLeft && bedroomInputRight) {
      const bedroomMin = parseInt(bedroomInputLeft.min);
      const bedroomMax = parseInt(bedroomInputRight.max);
      const bedroomValues = Array.from({length: bedroomMax - bedroomMin + 1}, (_, i) => i + bedroomMin);

      initializeDiscreteRangeSlider({
        inputLeftId: 'bedroom-input-left',
        inputRightId: 'bedroom-input-right',
        sliderRangeId: 'bedroom-slider-range',
        titleMinId: 'bedroom-title-min',
        titleMaxId: 'bedroom-title-max',
        hiddenMinInputId: 'hidden-min-bedroom-count',
        hiddenMaxInputId: 'hidden-max-bedroom-count',
        dotLeftId: 'bedroom-dot-left',
        dotRightId: 'bedroom-dot-right',
        values: bedroomValues
      });
    }

    // Initialize the bathroom count slider
    const bathroomInputLeft = document.getElementById('bathroom-input-left');
    const bathroomInputRight = document.getElementById('bathroom-input-right');

    if (bathroomInputLeft && bathroomInputRight) {
      const bathroomMin = parseInt(bathroomInputLeft.min);
      const bathroomMax = parseInt(bathroomInputRight.max);
      const bathroomValues = Array.from({length: bathroomMax - bathroomMin + 1}, (_, i) => i + bathroomMin);

      initializeDiscreteRangeSlider({
        inputLeftId: 'bathroom-input-left',
        inputRightId: 'bathroom-input-right',
        sliderRangeId: 'bathroom-slider-range',
        titleMinId: 'bathroom-title-min',
        titleMaxId: 'bathroom-title-max',
        hiddenMinInputId: 'hidden-min-bathroom-count',
        hiddenMaxInputId: 'hidden-max-bathroom-count',
        dotLeftId: 'bathroom-dot-left',
        dotRightId: 'bathroom-dot-right',
        values: bathroomValues
      });
    }
  });
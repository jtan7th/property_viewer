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
        index = Math.min(index, parseInt(inputRight.value) - 1);
        
        const percent = (index / max) * 100;
        sliderRange.style.left = percent + '%';
        sliderRange.style.width = (parseInt(inputRight.value) - index) / max * 100 + '%';
        titleMin.innerText = values[index];
        if (hiddenMinInput) hiddenMinInput.value = values[index];
        if (dotLeft) dotLeft.style.left = percent + '%';
        if (this.form) submitForm(this.form);
      }

      function setRightValue() {
        let index = parseInt(this.value);
        index = Math.max(index, parseInt(inputLeft.value) + 1);
        
        const percent = ((max - index) / max) * 100;
        sliderRange.style.right = percent + '%';
        sliderRange.style.width = (index - parseInt(inputLeft.value)) / max * 100 + '%';
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
  });
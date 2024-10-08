document.addEventListener('DOMContentLoaded', function() {
    function initializeDiscreteRangeSlider(options) {
      const inputLeft = document.getElementById(options.inputLeftId);
      const inputRight = document.getElementById(options.inputRightId);
      const sliderRange = document.getElementById(options.sliderRangeId);
      const titleMin = document.getElementById(options.titleMinId);
      const titleMax = document.getElementById(options.titleMaxId);
      const hiddenMinInput = document.getElementById(options.hiddenMinInputId);
      const hiddenMaxInput = document.getElementById(options.hiddenMaxInputId);

      const values = options.values;
      const max = values.length - 1;

      function setLeftValue() {
        let index = parseInt(this.value);
        index = Math.min(index, parseInt(inputRight.value) - 1);
        
        const percent = (index / max) * 100;
        sliderRange.style.left = percent + '%';
        titleMin.innerText = values[index];
        if (hiddenMinInput) hiddenMinInput.value = index === 0 ? 'Any' : values[index];
        if (this.form) submitForm(this.form);
      }

      function setRightValue() {
        let index = parseInt(this.value);
        index = Math.max(index, parseInt(inputLeft.value) + 1);
        
        const percent = ((max - index) / max) * 100;
        sliderRange.style.right = percent + '%';
        titleMax.innerText = values[index];
        if (hiddenMaxInput) hiddenMaxInput.value = values[index];
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
    initializeDiscreteRangeSlider({
      inputLeftId: 'bedroom-input-left',
      inputRightId: 'bedroom-input-right',
      sliderRangeId: 'bedroom-slider-range',
      titleMinId: 'bedroom-title-min',
      titleMaxId: 'bedroom-title-max',
      hiddenMinInputId: 'hidden-min-bedroom-count',
      hiddenMaxInputId: 'hidden-max-bedroom-count',
      values: ['0', '1', '2', '3', '4', '5']
    });
  });
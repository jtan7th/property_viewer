document.addEventListener('DOMContentLoaded', function() {
  function initializeRangeSlider(options) {
    var inputLeft = document.getElementById(options.inputLeftId);
    var inputRight = document.getElementById(options.inputRightId);
    var dotLeft = document.getElementById(options.dotLeftId);
    var dotRight = document.getElementById(options.dotRightId);
    var sliderRange = document.getElementById(options.sliderRangeId);
    var titleMin = document.getElementById(options.titleMinId);
    var titleMax = document.getElementById(options.titleMaxId);
    var hiddenMinInput = document.getElementById(options.hiddenMinInputId);
    var hiddenMaxInput = document.getElementById(options.hiddenMaxInputId);

    function formatValue(value) {
      if (options.formatFunction) {
        return options.formatFunction(value);
      }
      return value !== null && value !== undefined ? value : 'N/A';
    }

    function setLeftValue() {
      let value = this.value;
      let min = parseInt(this.min) || 0;
      let max = parseInt(this.max) || 100;

      value = Math.min(parseInt(value) || min, parseInt(inputRight.value) - 1);

      let percent = ((value - min) / (max - min)) * 100;

      sliderRange.style.left = percent + '%';
      if (dotLeft) dotLeft.style.left = percent + '%';
      if (titleMin) titleMin.innerText = formatValue(value);
      if (hiddenMinInput) hiddenMinInput.value = value;
      if (this.form) submitForm(this.form);
    }

    function setRightValue() {
      let value = this.value;
      let min = parseInt(this.min) || 0;
      let max = parseInt(this.max) || 100;

      value = Math.max(parseInt(value) || max, parseInt(inputLeft.value) + 1);

      let percent = ((value - min) / (max - min)) * 100;

      sliderRange.style.right = (100 - percent) + '%';
      if (dotRight) dotRight.style.right = (100 - percent) + '%';
      if (titleMax) titleMax.innerText = formatValue(value);
      if (hiddenMaxInput) hiddenMaxInput.value = value;
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

  function formatPrice(price) {
    if (price === null || price === undefined || isNaN(price)) {
      return 'N/A';
    }
    price = Number(price);
    if (price >= 1000000) {
      return '$' + (price / 1000000).toFixed(1) + 'm';
    } else if (price >= 1000) {
      return '$' + (price / 1000).toFixed(0) + 'k';
    } else {
      return '$' + price;
    }
  }

  function formatArea(area) {
    return area + ' sqm';
  }

  // Initialize sliders for different attributes
  initializeRangeSlider({
    inputLeftId: 'input-left',
    inputRightId: 'input-right',
    dotLeftId: 'dot-left',
    dotRightId: 'dot-right',
    sliderRangeId: 'slider-range',
    titleMinId: 'title-min',
    titleMaxId: 'title-max',
    hiddenMinInputId: 'hidden-min-price',
    hiddenMaxInputId: 'hidden-max-price',
    formatFunction: formatPrice
  });

  initializeRangeSlider({
    inputLeftId: 'floor-area-input-left',
    inputRightId: 'floor-area-input-right',
    dotLeftId: 'floor-area-dot-left',
    dotRightId: 'floor-area-dot-right',
    sliderRangeId: 'floor-area-slider-range',
    titleMinId: 'floor-area-title-min',
    titleMaxId: 'floor-area-title-max',
    hiddenMinInputId: 'hidden-min-floor-area',
    hiddenMaxInputId: 'hidden-max-floor-area',
    formatFunction: formatArea
  });

  initializeRangeSlider({
    inputLeftId: 'land-area-input-left',
    inputRightId: 'land-area-input-right',
    dotLeftId: 'land-area-dot-left',
    dotRightId: 'land-area-dot-right',
    sliderRangeId: 'land-area-slider-range',
    titleMinId: 'land-area-title-min',
    titleMaxId: 'land-area-title-max',
    hiddenMinInputId: 'hidden-min-land-area',  // Changed from 'land-area-min-value'
    hiddenMaxInputId: 'hidden-max-land-area',  // Changed from 'land-area-max-value'
    formatFunction: formatArea
  });
});
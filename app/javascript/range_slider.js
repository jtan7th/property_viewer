document.addEventListener('DOMContentLoaded', function() {
  function initializeRangeSlider(options) {
    var inputLeft = document.getElementById(options.inputLeftId);
    var inputRight = document.getElementById(options.inputRightId);
    var dotLeft = document.getElementById(options.dotLeftId);
    var dotRight = document.getElementById(options.dotRightId);
    var sliderRange = document.getElementById(options.sliderRangeId);
    var minValue = document.getElementById(options.minValueId);
    var maxValue = document.getElementById(options.maxValueId);

    function setLeftValue() {
      let value = Math.min(parseInt(this.value), parseInt(inputRight.value) - 1);
      let min = parseInt(this.min);
      let max = parseInt(this.max);

      let percent = ((value - min) / (max - min)) * 100;

      sliderRange.style.left = percent + '%';
      dotLeft.style.left = percent + '%';
      minValue.value = value;
      inputLeft.value = value;
    }

    function setRightValue() {
      let value = Math.max(parseInt(this.value), parseInt(inputLeft.value) + 1);
      let min = parseInt(this.min);
      let max = parseInt(this.max);

      let percent = ((value - min) / (max - min)) * 100;

      sliderRange.style.right = (100 - percent) + '%';
      dotRight.style.right = (100 - percent) + '%';
      maxValue.value = value;
      inputRight.value = value;
    }

    function updateSlider(input, isLeft) {
      let value = parseInt(input.value);
      let min = parseInt(inputLeft.min);
      let max = parseInt(inputRight.max);

      if (isNaN(value)) {
        value = isLeft ? min : max;
      }

      value = Math.min(Math.max(value, min), max);

      if (isLeft) {
        value = Math.min(value, parseInt(inputRight.value) - 1);
        inputLeft.value = value;
      } else {
        value = Math.max(value, parseInt(inputLeft.value) + 1);
        inputRight.value = value;
      }

      let percent = ((value - min) / (max - min)) * 100;

      if (isLeft) {
        sliderRange.style.left = percent + '%';
        dotLeft.style.left = percent + '%';
      } else {
        sliderRange.style.right = (100 - percent) + '%';
        dotRight.style.right = (100 - percent) + '%';
      }

      input.value = value;
    }

    inputLeft.addEventListener('input', setLeftValue);
    inputRight.addEventListener('input', setRightValue);

    inputLeft.addEventListener('change', function() {
      this.form.requestSubmit();
    });
    inputRight.addEventListener('change', function() {
      this.form.requestSubmit();
    });

    minValue.addEventListener('input', function() {
      updateSlider(this, true);
    });

    maxValue.addEventListener('input', function() {
      updateSlider(this, false);
    });

    // Initialize the slider
    setLeftValue.call(inputLeft);
    setRightValue.call(inputRight);
  }

  // Initialize sliders for different attributes
  initializeRangeSlider({
    inputLeftId: 'sale-price-input-left',
    inputRightId: 'sale-price-input-right',
    dotLeftId: 'sale-price-dot-left',
    dotRightId: 'sale-price-dot-right',
    sliderRangeId: 'sale-price-slider-range',
    minValueId: 'sale-price-min-value',
    maxValueId: 'sale-price-max-value'
  });

  initializeRangeSlider({
    inputLeftId: 'land-area-input-left',
    inputRightId: 'land-area-input-right',
    dotLeftId: 'land-area-dot-left',
    dotRightId: 'land-area-dot-right',
    sliderRangeId: 'land-area-slider-range',
    minValueId: 'land-area-min-value',
    maxValueId: 'land-area-max-value'
  });

  initializeRangeSlider({
    inputLeftId: 'floor-area-input-left',
    inputRightId: 'floor-area-input-right',
    dotLeftId: 'floor-area-dot-left',
    dotRightId: 'floor-area-dot-right',
    sliderRangeId: 'floor-area-slider-range',
    minValueId: 'floor-area-min-value',
    maxValueId: 'floor-area-max-value'
  });
});
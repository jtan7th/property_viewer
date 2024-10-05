document.addEventListener('DOMContentLoaded', function() {
  var inputLeft = document.getElementById('input-left');
  var inputRight = document.getElementById('input-right');
  
  var dotLeft = document.getElementById('dot-left');
  var dotRight = document.getElementById('dot-right');

  var sliderRange = document.getElementById('slider-range');

  var minSalePrice = document.getElementById('min-sale-price');
  var maxSalePrice = document.getElementById('max-sale-price');

  function setLeftValue() {
    let value = Math.min(parseInt(this.value), parseInt(inputRight.value) - 1);
    let min = parseInt(this.min);
    let max = parseInt(this.max);

    let percent = ((value - min) / (max - min)) * 100;

    sliderRange.style.left = percent + '%';
    dotLeft.style.left = percent + '%';
    minSalePrice.value = value;
    inputLeft.value = value;
  }

  function setRightValue() {
    let value = Math.max(parseInt(this.value), parseInt(inputLeft.value) + 1);
    let min = parseInt(this.min);
    let max = parseInt(this.max);

    let percent = ((value - min) / (max - min)) * 100;

    sliderRange.style.right = (100 - percent) + '%';
    dotRight.style.right = (100 - percent) + '%';
    maxSalePrice.value = value;
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

  // Add these new event listeners
  inputLeft.addEventListener('change', function() {
    this.form.requestSubmit();
  });
  inputRight.addEventListener('change', function() {
    this.form.requestSubmit();
  });

  minSalePrice.addEventListener('input', function() {
    updateSlider(this, true);
  });

  maxSalePrice.addEventListener('input', function() {
    updateSlider(this, false);
  });

  // Initialize the slider
  setLeftValue.call(inputLeft);
  setRightValue.call(inputRight);
});
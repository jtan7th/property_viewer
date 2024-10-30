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

  if (!inputLeft || !inputRight) return;

  const values = options.values;
  const max = values.length - 1;
  const suffix = options.suffix || '';

  function setLeftValue() {
    let index = parseInt(this.value);
    let rightIndex = parseInt(inputRight.value);
    
    index = Math.min(index, rightIndex);
    this.value = index;
    
    const percent = (index / max) * 100;
    sliderRange.style.left = percent + '%';
    sliderRange.style.width = (rightIndex - index) / max * 100 + '%';
    titleMin.innerText = values[index] + suffix;
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
    titleMax.innerText = values[index] + suffix;
    if (hiddenMaxInput) hiddenMaxInput.value = values[index];
    if (dotRight) dotRight.style.right = percent + '%';
    if (this.form) submitForm(this.form);
  }

  function submitForm(form) {
    clearTimeout(window.submitTimer);
    window.submitTimer = setTimeout(() => {
      form.requestSubmit();
    }, 50);
  }

  inputLeft.addEventListener('input', setLeftValue);
  inputRight.addEventListener('input', setRightValue);

  function createPips() {
    const pipsContainer = document.createElement('div');
    pipsContainer.className = 'pips-container';
    pipsContainer.style.position = 'absolute';
    pipsContainer.style.width = '100%';
    pipsContainer.style.height = '10px';
    pipsContainer.style.top = '15px';

    for (let i = 1; i < values.length - 1; i++) {
      const pip = document.createElement('div');
      pip.className = 'pip';
      pip.style.position = 'absolute';
      pip.style.left = `${(i / max) * 100}%`;
      pip.style.width = '1px';
      pip.style.height = '5px';
      pip.style.backgroundColor = 'rgba(0, 0, 0, 0.2)';
      pipsContainer.appendChild(pip);
    }

    sliderRange.parentNode.appendChild(pipsContainer);
  }

  createPips();
  setLeftValue.call(inputLeft);
  setRightValue.call(inputRight);
}

function initializeAllDiscreteSliders() {
  try {
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
        values: bedroomValues,
        suffix: ' Bedrooms' 
      });
    }

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
        values: bathroomValues,
        suffix: ' Bathrooms' 
      });
    }

    const carparkInputLeft = document.getElementById('carpark-input-left');
    const carparkInputRight = document.getElementById('carpark-input-right');

    if (carparkInputLeft && carparkInputRight) {
      const carparkMin = parseInt(carparkInputLeft.min);
      const carparkMax = parseInt(carparkInputRight.max);
      const carparkValues = Array.from({length: carparkMax - carparkMin + 1}, (_, i) => i + carparkMin);

      initializeDiscreteRangeSlider({
        inputLeftId: 'carpark-input-left',
        inputRightId: 'carpark-input-right',
        sliderRangeId: 'carpark-slider-range',
        titleMinId: 'carpark-title-min',
        titleMaxId: 'carpark-title-max',
        hiddenMinInputId: 'hidden-min-carpark-spaces-count',
        hiddenMaxInputId: 'hidden-max-carpark-spaces-count',
        dotLeftId: 'carpark-dot-left',
        dotRightId: 'carpark-dot-right',
        values: carparkValues,
        suffix: ' Spaces' 
      });
    }
  } catch (error) {}
}

document.addEventListener('DOMContentLoaded', initializeAllDiscreteSliders);
document.addEventListener('turbo:load', initializeAllDiscreteSliders);
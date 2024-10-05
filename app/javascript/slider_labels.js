console.log('slider_labels.js loaded');

function updateSliderLabels(slider) {
    const value = parseFloat(slider.value);
    const formattedValue = new Intl.NumberFormat('en-US', { 
        style: 'currency', 
        currency: 'USD',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    }).format(value);
    
    // Update a label element with the formatted value
    const labelElement = document.getElementById(`${slider.id}-label`);
    if (labelElement) {
        labelElement.textContent = formattedValue;
    } else {
        console.error(`Label element for ${slider.id} not found`);
    }
}

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('input-left').addEventListener('input', function() {
        updateSliderLabels(this);
    });
    document.getElementById('input-right').addEventListener('input', function() {
        updateSliderLabels(this);
    });
});
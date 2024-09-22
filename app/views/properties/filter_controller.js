import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "filterValue" ]

  connect() {
    console.log("Filter controller connected")
  }

  updateFilterValues() {
    console.log("updateFilterValues called")
    const selectedFilter = this.element.querySelector('select[name="filter_by"]').value
    console.log("Selected filter:", selectedFilter)
    if (!selectedFilter) return

    const url = `/properties/filter_values?filter_by=${selectedFilter}`
    console.log("Fetching from URL:", url)

    fetch(url)
      .then(response => response.json())
      .then(data => {
        console.log("Received data:", data)
        this.filterValueTarget.innerHTML = '<option value="">Select Value</option>'
        data.forEach(option => {
          const optionElement = document.createElement('option')
          optionElement.value = option
          optionElement.textContent = option
          this.filterValueTarget.appendChild(optionElement)
        })
      })
      .catch(error => console.error('Error:', error))
  }
}

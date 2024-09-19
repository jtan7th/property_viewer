import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "filterBy", "filterValue" ]

  connect() {
    this.updateFilterValues()
  }

  updateFilterValues() {
    const selectedFilter = this.filterByTarget.value
    if (!selectedFilter) return

    fetch(`/properties.json?filter_by=${selectedFilter}`)
      .then(response => response.json())
      .then(data => {
        this.filterValueTarget.innerHTML = '<option value="">Select Value</option>'
        data.forEach(option => {
          const optionElement = document.createElement('option')
          optionElement.value = option
          optionElement.textContent = option
          this.filterValueTarget.appendChild(optionElement)
        })
      })
  }
}
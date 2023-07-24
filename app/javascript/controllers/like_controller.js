import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {

  static targets = ["count"]

  hi(e){
    e.preventDefault()
    const currentValue = Number(this.countTarget.textContent)
    this.countTarget.textContent = currentValue + 1

    if(currentValue >= 5){
      const detail = { detail: {currentValue: currentValue}}
      const evt = new CustomEvent("over5", detail)
      window.dispatchEvent(evt)
    }
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  change(e){
    const {currentValue} = e.detail
    this.element.textContent = currentValue + 1
  }
}

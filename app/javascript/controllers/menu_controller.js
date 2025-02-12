import { Controller } from "@hotwired/stimulus"

export default class MenuController extends Controller {
  static targets = ["dropdown"]

  toggle() {
    console.log("Toggling dropdown")
    this.dropdownTarget.classList.toggle("hidden")
  }
}

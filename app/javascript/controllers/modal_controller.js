import { Controller } from "@hotwired/stimulus"

export default class ModalController extends Controller {
  static targets = ["modal"];

  // Open modal by id
  open(event) {
    const modalId = event.target.dataset.modalTarget;
    const modal = document.getElementById(modalId);

    if (modal) {
      modal.classList.remove("hidden");
    }
  }

  // Close any modal
  close(event) {
    const modal = event.target.closest(".modal");
    modal.classList.add("hidden");
  }
}

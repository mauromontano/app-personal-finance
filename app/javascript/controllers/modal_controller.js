import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"];

  // Abrir el modal según el id
  open(event) {
    const modalId = event.target.dataset.modalTarget;
    const modal = document.getElementById(modalId);

    if (modal) {
      modal.classList.remove("hidden");
    }
  }

  // Cerrar cualquier modal
  close(event) {
    const modal = event.target.closest(".modal");
    modal.classList.add("hidden");
  }
}

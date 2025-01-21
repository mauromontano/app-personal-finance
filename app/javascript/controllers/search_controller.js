import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class SearchController extends Controller {
  static targets = [ "input", "pageSelect" ]

  search() {
    const query = this.inputTarget.value.trim();
    const url = query ? `/movies?query=${query}` : "/";

    Turbo.visit(url, { frame: "movies_list" });
  }

  goToPage(event) {
    const selectedPage = event.target.value

    Turbo.visit(`/movies?page=${selectedPage}`)
  }
}

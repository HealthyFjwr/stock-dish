import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "count", "submit"]

  connect() {
    this.update()
  }

  update() {
    const count = this.checkboxTargets.filter((checkbox) => checkbox.checked).length

    this.countTargets.forEach((target) => { target.textContent = count })
    this.submitTarget.disabled = count === 0
  }

  clear() {
    this.checkboxTargets.forEach((checkbox) => { checkbox.checked = false })
    this.update()
  }
}

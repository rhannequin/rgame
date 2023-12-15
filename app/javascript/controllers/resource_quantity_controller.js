import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { quantity: Number, rate: Number }
  static targets = ["quantity"]

  connect() {
    this.quantityCounter = this.start()
  }

  start() {
    return setInterval(() => {
      this.quantityValue += this.rateValue
      this.updateCounter()
    }, 1000)
  }

  updateCounter() {
    this.quantityTarget.innerHTML = this.quantityValue.toLocaleString()
  }

  disconnect() {
    clearInterval(this.quantityCounter)
  }
}

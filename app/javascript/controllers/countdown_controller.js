import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { remainingTimeSeconds: Number }
  static targets = ["timer"]

  connect() {
    this.counter = this.start()
  }

  start() {
    return setInterval(() => {
      this.remainingTimeSecondsValue--
      this.updateTimer()
    }, 1000)
  }

  updateTimer() {
    this.timerTarget.innerHTML = this.secondsToTime()
  }

  secondsToTime() {
    const seconds = this.remainingTimeSecondsValue
    const minutes = Math.floor(seconds / 60)
    const hours = Math.floor(minutes / 60)
    const remainingSeconds = seconds % 60
    const remainingMinutes = minutes % 60

    return [
      this.leadingZero(hours),
      this.leadingZero(remainingMinutes),
      this.leadingZero(remainingSeconds),
    ].join(":")
  }

  leadingZero(duration) {
    return duration.toString().padStart(2, "0")
  }

  disconnect() {
    clearInterval(this.counter)
  }
}

import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="category"
export default class extends Controller {
  connect() {
    console.log("category open") 
    this.modal = new Modal(this.element)
    this.modal.show()
  }

  disconnect() {
    // 問題が起きる可能性があるので念のためモーダルを廃棄する
    this.modal.dispose();
  }

  close(event) {
    console.log("close_login")
    if (event.detail.success) {
      this.modal.hide()
    }
  }

}
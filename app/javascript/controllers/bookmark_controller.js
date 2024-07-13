import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="bookmark"
export default class extends Controller {
  connect() {
    console.log("bookmark open") 
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
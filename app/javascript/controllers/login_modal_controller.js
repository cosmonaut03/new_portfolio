import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    console.log("aaaログイン")
    var registerModalElement = document.getElementById('registerModal');
    if (registerModalElement !== null ) {
      var modalInstance = Modal.getInstance(registerModalElement);
      if (modalInstance._isShown) {
        modalInstance.hide();
      } 
    }
    this.modal = new Modal(this.element)
    this.modal.show()
  }

  disconnect() {
    // 問題が起きる可能性があるので念のためモーダルを廃棄する
    this.modal.dispose();
    console.log("BBB del")
  }

  close(event) {
    console.log("close_login")
    if (event.detail.success) {
      this.modal.hide()
    }
  }

  handleResponse(event) {
    // リダイレクトが発生した場合、モーダルを閉じる
    console.log("redirect: login")
    if (event.detail.fetchResponse.redirected) {
      this.modal.hide()
    }
  }
}
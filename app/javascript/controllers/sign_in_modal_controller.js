import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="sign-in-modal"
export default class  extends Controller {
  connect() {
    console.log("aaa登録")

    var loginModalElement = document.getElementById('loginModal');

    if (loginModalElement !== null ) {
      var modalInstance = Modal.getInstance(loginModalElement);
      console.log(modalInstance)
      if (modalInstance._isShown) {
        console.log('モーダルは開いています。');
        // モーダルを閉じる
        modalInstance.hide();
      } 
    }

    this.modal = new Modal(this.element)
    console.log(this.modal)
    this.modal.show()
  }

  disconnect() {
    // 問題が起きる可能性があるので念のためモーダルを廃棄する
    console.log("aaa削除")
    this.modal.hide()
    this.modal.dispose();
  }

  closeModal() {
    console.log("aaa閉じる")
    this.modal.hide();
  }

  close(event) {
    console.log("close_user")
    if (event.detail.success) {
      this.modal.hide()
    }
  }

  handleResponse(event) {
    // リダイレクトが発生した場合、モーダルを閉じる
    console.log("redirect")
    if (event.detail.fetchResponse.redirected) {
      this.modal.hide()
    }
  }

}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {

  connect() {
    const { id, liked } = this.element.dataset;
    this.id = id;

    if (liked == "true") {
      this.likebtnTarget.value = "已讚";
    } else {
      this.likebtnTarget.value = "未讚";
    }
  }
  static targets = ["likebtn"]

  toggle(e){

    e.preventDefault()

    const url = `/api/v1/articles/${this.id}/like`
    const token = document.querySelector("meta[name=csrf-token]").content
    //API
    fetch(url,{
      method: "PATCH",
      headers: {
        "X-CSRF-Token": token,
      }
    }).then(
      resp => {
        return resp.json()
      }
    ).then(
      ({liked}) => {
        if (liked) {
          this.likebtnTarget.value = "已讚";
        } else {
          this.likebtnTarget.value = "未讚";
        }
      }
    ).catch( 
      err => {
      console.log(err);
    })

  }
}

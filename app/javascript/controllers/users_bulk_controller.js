import CheckboxSelectAll from "stimulus-checkbox-select-all"
import Rails from "@rails/ujs"

// https://www.stimulus-components.com/docs/stimulus-checkbox-select-all/

export default class extends CheckboxSelectAll {
  destroy(event) {
    event.preventDefault()

    let data = new FormData()
    if (this.checked.length == this.checkboxTargets.length) {
      data.append("all", true)
    } else {
      this.checked.forEach((checkbox) => data.append("user_ids[]", checkbox.value))
    }

    Rails.ajax({
      url: "/users/bulk_destroy",
      type: "DELETE",
      data: data
    })
  }
}

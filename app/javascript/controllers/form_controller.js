import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Submit the form with the event name as a hidden input.
  submitEvent({ params }) {
    if (params.event) {
      console.log("submitEvent", params);
      const hiddenFormEvent = document.createElement('input');
      hiddenFormEvent.type = 'hidden';
      hiddenFormEvent.name = "form_event"
      hiddenFormEvent.value = params.event;
      this.element.appendChild(hiddenFormEvent);
      this.element.requestSubmit();
      this.element.removeChild(hiddenFormEvent);
    } else {
      console.log("No event found for element", params);
    }
  }
}


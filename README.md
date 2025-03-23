# Simple Hotwire cascading form example

![Cascading Form Demo](app/assets/images/demo.gif)

This demo shows how the cascading form works. When a country is selected, the states dropdown is updated with states from that country. When a state is selected, the cities dropdown is updated with cities from that state.

## Running Locally
```
bin/rails db:setup
bin/rails db:seed
bin/dev
```

Navigate to [http://0.0.0.0:3000/citizens/new](http://0.0.0.0:3000/citizens/new)

## Implementing this pattern in your own code

1. In your form partial (e.g., `app/views/citizens/_select_countries.html.erb`), add a select element with data attributes:
   - Set `data-action` to `form#submitEvent` to bind the event to the `form` Stimulus controller.
   - Include a custom parameter via `data-form_event_param` (e.g., `country_change`) to indicate which change occurred.

  For example:
  ```erb
  <%= form.select :country_id,
       # ...
       { data: { action: "form#submitEvent", form_event_param: "country_change" } }
  %>
  ```

2. On the client side, implement a `form` Stimulus controller (`app/javascript/controllers/form_controller.js`) that listens to the form events. This controller intercepts the event (e.g., change event on the select), and submits the form along with an extra parameter (`form_event`) which is read from the data attribute.

3. In the Rails controller (e.g., `CitizensController`), a before_action (`handle_form_event`) checks for the presence of the `form_event` parameter. If present, it dynamically calls the appropriate method (such as `on_country_change` or `on_state_change`) via Ruby's `send` method.

4. Within these event handling methods, dependent fields are reset (for instance, clearing out state or city selections) and Turbo Streams are used to replace part of the form via a partial render (using `turbo_stream.replace`). This enables a dynamic update of the form without a full page reload.

To implement this pattern in your own codebase:
   - Set up your form fields with the described data attributes.
   - Create a Stimulus controller to handle the events and submit the form with the additional parameter.
   - Add a before_action in your controller to detect the event and call the related method.
   - Use Turbo Streams to update form fragments dynamically.

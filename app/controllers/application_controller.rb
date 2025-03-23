class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  # Handle the form event parameter that is passed from the client.
  def handle_form_event
    return true unless request.post? || request.patch? || request.put?
    return true unless params[:form_event].present?

    method_name = "on_#{params[:form_event]}"
    if respond_to?(method_name, true)
      send(method_name)
    else
      raise(ActionController::RoutingError, "No method `#{method_name}` found")
    end
    false # Prevent the default form submission.
  end
end

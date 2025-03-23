class CitizensController < ApplicationController
  before_action :set_citizen
  before_action :load_countries_states_and_cities
  before_action :handle_form_event, only: [ :create, :update ]

  def new
  end
  def create
    if @citizen.save
      redirect_to new_citizen_path, notice: "Citizen created successfully"
    else
      render :new, status: :unprocessable_entity, alert: "Citizen creation failed"
    end
  end

  private

  def set_citizen
    @citizen = Citizen.new
    @citizen.assign_attributes(citizen_params) if citizen_params.present?
  end

  def load_countries_states_and_cities
    @countries = Country.order(:name)
    @states = State.where(country_id: @citizen.country_id).order(:name)
    @cities = City.where(state_id: @citizen.state_id).order(:name)
  end

  # Handle the form event parameter that is passed from the client.
  # This method could be moved to ApplicationController.
  def handle_form_event
    return true unless params[:form_event].present?

    method_name = "on_#{params[:form_event]}"
    if respond_to?(method_name, true)
      send(method_name)
    else
      raise(ActionController::RoutingError, "No method `#{method_name}` found")
    end
    false # Prevent the default form submission.
  end

  def on_country_change
    @citizen.state = nil
    @citizen.city = nil
    stream_replace_form_with_partial
  end

  def on_state_change
    @citizen.city = nil
    stream_replace_form_with_partial
  end

  # Replace the form with its partial via turbo_stream.
  def stream_replace_form_with_partial
    render turbo_stream: turbo_stream.replace(:citizen_form, partial: "citizens/form", locals: { citizen: @citizen })
  end

  def citizen_params
    params.require(:citizen).permit(:name, :country_id, :state_id, :city_id) if params[:citizen].present?
  end
end

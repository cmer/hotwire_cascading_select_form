class CitizensController < ApplicationController
  before_action :set_citizen
  before_action :load_countries_states_and_cities
  before_action :handle_form_event # this is defined in ApplicationController

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

  # Load the dropdown options countries, states and cities for @citizen.
  def load_countries_states_and_cities
    @countries = Country.order(:name)
    @states = State.where(country_id: @citizen.country_id).order(:name)
    @cities = City.where(state_id: @citizen.state_id).order(:name)
  end

  # Triggered by the `country_change` event.
  def on_country_change
    @citizen.state = nil
    @citizen.city = nil
    stream_replace_form_with_partial
  end

  # Triggered by the `state_change` event.
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

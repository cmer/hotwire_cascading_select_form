class Citizen < ApplicationRecord
  belongs_to :city
  belongs_to :state
  belongs_to :country

  validates :name, presence: true
  validates :city_id, presence: true
  validates :state_id, presence: true
  validates :country_id, presence: true
end

Citizen.delete_all
City.delete_all
State.delete_all
Country.delete_all

Country.create!(name: "United States") unless Country.exists?(name: "United States")
Country.create!(name: "Canada") unless Country.exists?(name: "Canada")

State.create!(name: "California", country: Country.first) unless State.exists?(name: "California", country: Country.first)
State.create!(name: "New York", country: Country.first) unless State.exists?(name: "New York", country: Country.first)
State.create!(name: "Texas", country: Country.first) unless State.exists?(name: "Texas", country: Country.first)
State.create!(name: "Ontario", country: Country.second) unless State.exists?(name: "Ontario", country: Country.second)
State.create!(name: "Quebec", country: Country.second) unless State.exists?(name: "Quebec", country: Country.second)
State.create!(name: "Alberta", country: Country.second) unless State.exists?(name: "Alberta", country: Country.second)

City.create!(name: "San Francisco", state: State.first) unless City.exists?(name: "San Francisco", state: State.first)
City.create!(name: "New York", state: State.second) unless City.exists?(name: "New York", state: State.second)
City.create!(name: "Austin", state: State.third) unless City.exists?(name: "Austin", state: State.third)
City.create!(name: "Toronto", state: State.fourth) unless City.exists?(name: "Toronto", state: State.fourth)
City.create!(name: "Montreal", state: State.fifth) unless City.exists?(name: "Montreal", state: State.fifth)
City.create!(name: "Calgary", state: State.all[5]) unless City.exists?(name: "Calgary", state: State.all[5])

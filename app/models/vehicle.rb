# The vehicle has information about the insurance rates which vary depending on the vehicle
# Both the driver and vehicle owner insurance has its own daily rate

class Vehicle < ActiveRecord::Base

  has_many :driver_insurances
  has_many :vehicle_owner_insurances
  belongs_to :owner
end

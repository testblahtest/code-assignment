class Vehicle < ActiveRecord::Base

  has_many :driver_insurances
  has_many :vehicle_owner_insurances
  belongs_to :owner
end

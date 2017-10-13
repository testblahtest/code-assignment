class Partner < ActiveRecord::Base

  has_many :driver_insurances
  has_many :owned_vehicles, foreign_key: "owner"
end

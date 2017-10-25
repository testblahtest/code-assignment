# The vehicle has information about the insurance rates which vary depending on the vehicle
# Both the driver and vehicle owner insurance has its own daily rate

class Vehicle < ActiveRecord::Base

  has_many :driver_insurances
  has_many :vehicle_owner_insurances
  belongs_to :owner, class_name: "Partner"

  def covered_by_driver_insurance_on(day)
    return driver_insurances.where("? between start_date and end_date", day).count>0
  end

  # TODO add method for owner insurance

end

# A Partner can be either a Driver or an Owner

class Partner < ActiveRecord::Base

  has_many :driver_insurances
  has_many :owned_vehicles, foreign_key: "owner"

  def total_driver_insurance_days

  end

  def self.driver_insurance_p(driver_insurance)
    (driver_insurance.end_date - driver_insurance.start_date).to_f * 58.50
  end

  def total_vehicle_owner_insurance_charges_pounds

  end
end

# A Partner can be either a Driver or an Owner

class Partner < ActiveRecord::Base

  has_many :driver_insurances, foreign_key: "driver_id"
  has_many :owned_vehicles, class_name: "Vehicle", foreign_key: "owner_id"

  def total_days_charged_for_all_driver_insurance_policies

  end

  def self.driver_insurance_p(driver_insurance)
    (driver_insurance.end_date - driver_insurance.start_date).to_f * 58.50
  end

  def total_vehicle_owner_insurance_charges_pounds

  end

  def total_vehicle_owner_insurance_v2_charges_pounds

  end

end

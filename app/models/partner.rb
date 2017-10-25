# A Partner can be either a Driver or an Owner
class Partner < ActiveRecord::Base

  has_many :driver_insurances, foreign_key: "driver_id"
  has_many :owned_vehicles, class_name: "Vehicle", foreign_key: "owner_id"

  # driver
  def total_days_charged_for_all_driver_insurance_policies
    driver_insurances.collect{ |d| d.num_days }.sum
  end

  def self.driver_insurance_cost(driver_insurance)
    driver_insurance.num_days* 58.50
  end

  def total_driver_insurance_cost
    driver_insurances.collect{ |di| di.num_days }.sum * 58.50
  end

  # owner
  def increase_rate_on(day)
    VehicleOwnerInsurance.where(:vehicle_id => owned_vehicles.pluck(:id) ).where("? between start_date and end_date", day).count>=3
  end

  def total_charges_new
    owned_vehicles.collect{ |v| v.vehicle_owner_insurances.collect{ |oi| oi.total_charge_new }.sum }.sum
  end

end

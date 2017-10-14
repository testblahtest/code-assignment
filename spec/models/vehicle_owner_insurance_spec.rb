require 'rails_helper'

RSpec.describe VehicleOwnerInsurance, type: :model do

  it "calculates the days covered (only covered not charged for)" do
    vehicle_owner_insurance = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days)
    expect(vehicle_owner_insurance.total_days_covered).to eq 8
  end

  it "calculates the total charge for a vehicle owner insurance (excludes any day charged for on the driver insurance for that vehicle)" do
    vehicle = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.1 )
    vehicle_owner_insurance = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days, vehicle: vehicle)
    driver_insurance = DriverInsurance.create(start_date: Date.today + 4.days, end_date: Date.today + 11.days, vehicle: vehicle)

    expect(vehicle_owner_insurance.total_charge_pounds).to eq 4.4
  end

  it "calculates the total charges for the owner using the version2 calculations" do
    # Version 2 of the vehicle owner pricing has been devised
  end

end

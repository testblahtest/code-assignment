require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it "checks if vehicle was covered by a driver insurance on a particular date" do
    vehicle1 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0)
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 3.days, vehicle: vehicle1)
    expect(vehicle1.covered_by_driver_insurance_on(Date.today+1.days)).to be true
  end

  it "checks if vehicle was NOT covered by a driver insurance on a particular date" do
    vehicle1 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0)
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 3.days, vehicle: vehicle1)
    expect( vehicle1.covered_by_driver_insurance_on(Date.today+10.days) ).to be false
  end
end

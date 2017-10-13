require 'rails_helper'

RSpec.describe DriverInsurance, type: :model do

  it "calculates the number of days on cover for a driver insurance policy" do
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week)
    expect(driver_insurance.numds).to eq 7
  end

  it "calculates the price for a driver insurance policy" do
    vehicle = Vehicle.create(driver_insurance_daily_rate_pounds: 58.50)
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week,
                                              vehicle: vehicle)
    expect(Partner.driver_insurance_p(driver_insurance)).to eq 7 * 58.50
  end

end
require 'rails_helper'

RSpec.describe DriverInsurance, type: :model do

  it "should not accept end date before start date" do
    driver_insurance = DriverInsurance.create(end_date: Date.today, start_date: Date.today + 1.week)
    expect(driver_insurance).to_not be_valid
  end

  it "should accept start date before end date" do
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week)
    expect(driver_insurance).to be_valid
  end

  it "calculates the number of days to charge for a driver insurance policy" do
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week)
    expect(driver_insurance.num_days).to eq 7
  end

  it "calculates the number of days to charge for all the insurance for one driver" do
    driver = Partner.create(name: "Danny")
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week, driver: driver)
    driver_insurance2 = DriverInsurance.create(start_date: Date.today - 3.weeks, end_date: Date.today - 1.week, driver: driver)

    expect(driver.total_days_charged_for_all_driver_insurance_policies).to eq 21
  end

  it "calculates the price for a driver insurance policy" do
    vehicle = Vehicle.create(driver_insurance_daily_rate_pounds: 58.50)
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week, vehicle: vehicle)
    expect(Partner.driver_insurance_cost(driver_insurance)).to eq 7 * 58.50
  end

  it "calculates total cost for all driver insurance policies" do
    driver = Partner.create(name: "Teddy")
    vehicle = Vehicle.create(driver_insurance_daily_rate_pounds: 58.50)
    driver_insurance1 = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week, vehicle: vehicle, driver: driver)
    driver_insurance2 = DriverInsurance.create(start_date: Date.today+2.weeks, end_date: Date.today + 3.weeks, vehicle: vehicle, driver: driver)
    expect(driver.total_driver_insurance_cost).to eq 14 * 58.50
  end

end

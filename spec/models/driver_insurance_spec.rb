require 'rails_helper'

RSpec.describe DriverInsurance, type: :model do

  it "number_of_days_to_charge counts the number of days on cover for a driver_insurance" do
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week)
    expect(driver_insurance.number_of_days_to_charge).to eq 7
  end

end
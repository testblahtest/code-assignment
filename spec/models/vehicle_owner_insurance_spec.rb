require 'rails_helper'

RSpec.describe VehicleOwnerInsurance, type: :model do

  it "should not accept end date before start date" do
    vehicle_owner_insurance = VehicleOwnerInsurance.create(end_date: Date.today, start_date: Date.today + 1.week)
    expect(vehicle_owner_insurance).to_not be_valid
  end

  it "should accept start date before end date" do
    vehicle_owner_insurance = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 1.week)
    expect(vehicle_owner_insurance).to be_valid
  end

  it "calculates the days covered" do
    vehicle_owner_insurance = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days)
    expect(vehicle_owner_insurance.total_days_covered).to eq 8
  end

  it "calculates the days charged (vehicle just sat there sad and alone)" do
    vehicle1 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.5)
    vehicle_owner_insurance = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days, vehicle: vehicle1)
    expect(vehicle_owner_insurance.total_charge_pounds).to eq 8*1.5
  end

  it "calculates days covered for insurance for 1 vehicle that has been rented just a few days" do
    vehicle1 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0)
    vehicle_owner_insurance1 = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days, vehicle: vehicle1)
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 3.days, vehicle: vehicle1)
    expect(vehicle_owner_insurance1.total_days_charged_for).to eq 5
  end

  it "calculates days charged for insurance for 1 vehicle that has been rented just a few days" do
    owner = Partner.create(name: "Willy")
    vehicle1 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 2, owner: owner)
    vehicle_owner_insurance1 = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days, vehicle: vehicle1)
    driver_insurance = DriverInsurance.create(start_date: Date.today+2.days, end_date: Date.today + 5.days, vehicle: vehicle1)
    expect(vehicle_owner_insurance1.total_charge_pounds).to eq 5*2
  end

  it "calculates days covered by insurance for 1 vehicle that has been rented the whole time" do
    owner = Partner.create(name: "Yamata Paru")
    vehicle1 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)
    vehicle_owner_insurance1 = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days, vehicle: vehicle1)
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 11.days, vehicle: vehicle1)
    expect(vehicle_owner_insurance1.total_days_charged_for).to eq 0
  end


  it "see if we should up the fee on a particular day" do
    owner = Partner.create(name: "Haifan Fan")
    vehicle1 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)
    vehicle_owner_insurance1 = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days, vehicle: vehicle1)

    vehicle2 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)
    vehicle_owner_insurance2 = VehicleOwnerInsurance.create(start_date: Date.today+6.days, end_date: Date.today + 10.days, vehicle: vehicle2)
    expect(vehicle_owner_insurance1.vehicle.owner.increase_rate_on(Date.today+6.days)).to eq false
  end

  it "we should up the fee on a particular day" do
    owner = Partner.create(name: "Vinny Spatulla")
    vehicle1 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)
    vehicle_owner_insurance1 = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days, vehicle: vehicle1)

    vehicle2 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)
    vehicle_owner_insurance2 = VehicleOwnerInsurance.create(start_date: Date.today+6.days, end_date: Date.today + 10.days, vehicle: vehicle2)

    vehicle3 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)
    vehicle_owner_insurance3 = VehicleOwnerInsurance.create(start_date: Date.today+3.days, end_date: Date.today + 7.days, vehicle: vehicle3)

    expect(vehicle_owner_insurance1.vehicle.owner.increase_rate_on(Date.today+6.days)).to eq true
  end

end

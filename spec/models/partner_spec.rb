require 'rails_helper'

RSpec.describe Partner, type: :model do

    it "calculates the total charges for the owner using the v2 calculations" do
      owner = Partner.create(name: "Dick Shmuckson")

      vehicle1 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)
      vehicle2 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)
      vehicle3 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)

      vehicle_owner_insurance1 = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days, vehicle: vehicle1)
      vehicle_owner_insurance2 = VehicleOwnerInsurance.create(start_date: Date.today + 3.days, end_date: Date.today + 4.days, vehicle: vehicle2)
      vehicle_owner_insurance3 = VehicleOwnerInsurance.create(start_date: Date.today + 3.days, end_date: Date.today + 7.days, vehicle: vehicle3)

      driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 11.days, vehicle: vehicle1)
      expect(owner.total_charges_new).to eq 0 + 2.2 + 2.2 + 3
    end

    it "calculates the total charges for the owner using the v2 calculations in a 2 cars scenario" do
      owner = Partner.create(name: "Yamavazi Acasa")

      vehicle1 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)
      vehicle2 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)
      vehicle3 = Vehicle.create(vehicle_owner_insurance_daily_rate_pounds: 1.0, owner: owner)

      vehicle_owner_insurance1 = VehicleOwnerInsurance.create(start_date: Date.today, end_date: Date.today + 7.days, vehicle: vehicle1)
      vehicle_owner_insurance2 = VehicleOwnerInsurance.create(start_date: Date.today + 3.days, end_date: Date.today + 4.days, vehicle: vehicle2)

      driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 11.days, vehicle: vehicle1)
      expect(owner.total_charges_new).to eq 2
    end

end

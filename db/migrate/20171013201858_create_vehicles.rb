class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :licence_plate
      t.float :driver_insurance_daily_rate_pounds
      t.float :vehicle_owner_insurance_daily_rate_pounds
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end

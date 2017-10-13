class CreateVehicleOwnerInsurances < ActiveRecord::Migration
  def change
    create_table :vehicle_owner_insurances do |t|
      t.date :start_date
      t.date :end_date
      t.integer :vehicle_id

      t.timestamps null: false
    end
  end
end

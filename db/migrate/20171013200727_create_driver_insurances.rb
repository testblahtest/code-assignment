class CreateDriverInsurances < ActiveRecord::Migration
  def change
    create_table :driver_insurances do |t|
      t.date :start_date
      t.date :end_date
      t.integer :driver_id
      t.integer :vehicle_id

      t.timestamps null: false
    end
  end
end

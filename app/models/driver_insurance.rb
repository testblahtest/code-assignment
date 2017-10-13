class DriverInsurance < ActiveRecord::Base

  belongs_to :driver, class_name:  "Partner"
  belongs_to :vehicle

  def number_of_days_to_charge
    (end_date - start_date).to_i
  end


end

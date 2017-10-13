class DriverInsurance < ActiveRecord::Base

  belongs_to :driver, class_name:  "Partner"
  belongs_to :vehicle

  def numds
    (end_date - start_date).to_f
  end

end

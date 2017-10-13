class DriverInsurance < ActiveRecord::Base

  belongs_to :driver, class_name:  "Partner"
  belongs_to :vehicle

end

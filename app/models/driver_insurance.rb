class DriverInsurance < ActiveRecord::Base

  belongs_to :driver, class_name:  "Partner"
  belongs_to :vehicle

  validate :insurance_dates_validator
  # TODO validate other attrs

  def insurance_dates_validator
    errors.add(:end_date, 'cannot be before start date.') if start_date > end_date
  end

  def date_range
    (start_date..end_date).to_a[0...-1]
  end

  def num_days
    date_range.size
  end

end

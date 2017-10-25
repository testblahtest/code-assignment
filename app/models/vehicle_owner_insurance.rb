class VehicleOwnerInsurance < ActiveRecord::Base

  belongs_to :vehicle

  validate :insurance_dates_validator
  # TODO validate other attrs

  def insurance_dates_validator
      errors.add(:end_date, 'cannot be before start date.') if start_date > end_date
  end

  def date_range
    (start_date..end_date).to_a
  end

  def total_days_covered
    date_range.size
  end

  def total_days_charged_for
    (date_range-vehicle.driver_insurances.collect{ |di| di.date_range }.flatten).size
  end

  def total_charge_pounds
    total_days_charged_for * vehicle.vehicle_owner_insurance_daily_rate_pounds
  end

  def should_charge_on(day)
    vehicle.driver_insurances.where("? between start_date and end_date", day).count==0
  end

  # new function
  def total_charge_new
    # NB: should preload VehicleOwnerInsurance query in increase_rate_on(day) somewhere to get rid of the N+1 issue. The other query will be taken care of by the framework (caching)
    date_range.collect{ |d|
      vehicle.vehicle_owner_insurance_daily_rate_pounds * ( should_charge_on(d)?(vehicle.owner.increase_rate_on(d)?1.1:1):0 )
    }.sum
  end

end

require 'test_helper'

describe UnavailabilityRange do
  it "end date must be after start date" do
    unavailability_range = UnavailabilityRange.new(start_date: Date.tomorrow, end_date: Date.today)
    assert_not unavailability_range.valid?
  end
  it "start date cannot be in the past" do
    unavailability_range = UnavailabilityRange.new(start_date: (Date.today) - 1.day, end_date: Date.tomorrow)
    assert_not unavailability_range.valid?
  end
end

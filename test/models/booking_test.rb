require 'test_helper'

describe Booking do
  it "closing day creation works" do
    booking = Booking.new(time_slot_type: 'day(s)', time_slot_quantity: 3, start_date: 'Sat, 23 Apr 2016', desk_id: 282, user_id: 212)
    assert booking.valid?
  end
  # it "must have a date" do
  #   booking = Booking.new()
  #   assert_not booking.valid?
  # end
end

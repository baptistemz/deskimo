require 'test_helper'

describe ClosingDay do
  it "closing day creation works" do
    closing_day = ClosingDay.new(date: 'Sat, 23 Apr 2016')
    assert closing_day.valid?
  end
  it "must have a date" do
    closing_day = ClosingDay.new()
    assert_not closing_day.valid?
  end
end

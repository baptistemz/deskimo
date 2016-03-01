require 'test_helper'

describe Desk do
  it "desk create must work" do
    desk = Desk.new(kind: 'open_space', quantity: 2, description: 'un bureau', half_day_price: 7, daily_price: 12, weekly_price: 50)
    assert desk.valid?
  end
  it "must have quantity" do
    desk = Desk.new(description: 'un bureau', half_day_price: 7, daily_price: 12, weekly_price: 50)
    assert_not desk.valid?
  end
  it "must have description" do
    desk = Desk.new(quantity: 2, half_day_price: 7, daily_price: 12, weekly_price: 50)
    assert_not desk.valid?
  end
  it "must have half_day_price" do
    desk = Desk.new(description: 'un bureau', quantity: 7, daily_price: 12, weekly_price: 50)
    assert_not desk.valid?
  end
  it "must have daily_price" do
    desk = Desk.new(description: 'un bureau', half_day_price: 7, quantity: 12, weekly_price: 50)
    assert_not desk.valid?
  end
  it "must have weekly_price" do
    desk = Desk.new(description: 'un bureau', half_day_price: 7, daily_price: 12, quantity: 50)
    assert_not desk.valid?
  end
  # it "gives an array of available dates" do
  #   @company = Company.new(name: "coucou", address: "2 rue du près", city: "lille", description: "un", postcode: "59000", picture: "", phone_number: "0707070707").save
  #   @desk = @company.desks.create(kind: 'open_space', quantity: 2, description: 'un bureau', half_day_price: 7, daily_price: 12, weekly_price: 50)
  #   availabilities = @desk.get_next_available_days_array
  #   assert availabilities.each{|a| a.kind_of?(String)}
  # end
end

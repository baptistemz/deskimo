require 'test_helper'

describe User do
  it "should have an email" do
    user = User.new(password: 'coucou', password_confirmation: 'coucou')
    assert_not user.valid?
  end
  it "should have a valid email" do
    user = User.new(email: "foo@bar", password: 'coucou', password_confirmation: 'coucou')
    assert_not user.valid?
  end
  it "should have a first_name on update" do
    @user = User.create(email: 'foo@bar.com', password: 'coucou', password_confirmation: 'coucou')
    @user.update(last_name: "bar")
    assert_not @user.valid?
  end
  it "should have a last_name on update" do
    @user = User.create(email: 'foo@bar.com', password: 'coucou', password_confirmation: 'coucou')
    @user.update(first_name: "foo")
    assert_not @user.valid?
  end
  it "should validate a full name user on update" do
    @user = User.create(email: 'foo@bar.com', password: 'coucou', password_confirmation: 'coucou')
    @user.update(first_name: "foo", last_name: "bar")
    assert_not @user.valid?
  end
end

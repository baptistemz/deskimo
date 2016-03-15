require "test_helper"

describe WelcomeMessage do
  let(:welcome_message) { WelcomeMessage.new }

  it "must be valid" do
    value(welcome_message).must_be :valid?
  end
end

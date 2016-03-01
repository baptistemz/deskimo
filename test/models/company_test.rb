require 'test_helper'

describe Company do
  it "company create must work" do
    test_image = fixture_path + "/3brasseurs.jpg"
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    company = Company.new(description: 'une entreprise', name: "Entreprise", address: "10 rue nationale" , city: "Lille", postcode: "59000", picture: file, phone_number: "0707070707")
    assert company.valid?
  end
  it "must have a picture" do
    company = Company.new(description: 'une entreprise', name: "Entreprise", address: "10 rue nationale" , city: "Lille", postcode: "59000", phone_number: "0707070707")
    assert_not company.valid?
  end
  it "must have a name" do
    test_image = fixture_path + "/3brasseurs.jpg"
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    company = Company.new(description: 'une entreprise', address: "10 rue nationale" , city: "Lille", postcode: "59000", picture: file, phone_number: "0707070707")
    assert_not company.valid?
  end
  it "must have a description" do
    test_image = fixture_path + "/3brasseurs.jpg"
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    company = Company.new(name: "Entreprise", address: "10 rue nationale" , city: "Lille", postcode: "59000", picture: file, phone_number: "0707070707")
    assert_not company.valid?
  end
  it "must have an address" do
    test_image = fixture_path + "/3brasseurs.jpg"
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    company = Company.new(description: 'une entreprise', name: "Entreprise", city: "Lille", postcode: "59000", picture: file, phone_number: "0707070707")
    assert_not company.valid?
  end
  it "must have a postcode" do
    test_image = fixture_path + "/3brasseurs.jpg"
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    company = Company.new(description: 'une entreprise', name: "Entreprise", address: "10 rue nationale" , city: "Lille", picture: file, phone_number: "0707070707")
    assert_not company.valid?
  end
  it "must have a city" do
    test_image = fixture_path + "/3brasseurs.jpg"
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    company = Company.new(description: 'une entreprise', name: "Entreprise", address: "10 rue nationale", postcode: "59000", picture: file, phone_number: "0707070707")
    assert_not company.valid?
  end
  it "must have a phone number" do
    test_image = fixture_path + "/3brasseurs.jpg"
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    company = Company.new(description: 'une entreprise', name: "Entreprise", address: "10 rue nationale" , city: "Lille", postcode: "59000", picture: file)
    assert_not company.valid?
  end
end

ActiveAdmin.register Company do

  index do
    selectable_column
    column :name
    column :id
    column :siret
    column :address
    column :city
    column :postcode
    column :created_at
    column :updated_at
    column :description
    column :coffee
    column :wifi
    column :printer
    column :scanner
    column :picture_file_name
    column :picture_content_type
    column :picture_file_size
    column :picture_updated_at
    column :latitude
    column :longitude
    column :user
    column :open_monday
    column :open_tuesday
    column :open_wednesday
    column :open_thursday
    column :open_friday
    column :open_saturday
    column :open_sunday
    column :activated
    column :start_time_am
    column :end_time_am
    column :start_time_pm
    column :end_time_pm
    actions
  end

  form do |f|
    f.inputs "legal info" do
      f.input :name
      f.input :id
      f.input :siret
      f.input :address
      f.input :city
      f.input :postcode
    end
    f.inputs "practical info" do
      f.input :latitude
      f.input :longitude
      f.input :open_monday
      f.input :open_tuesday
      f.input :open_wednesday
      f.input :open_thursday
      f.input :open_friday
      f.input :open_saturday
      f.input :open_sunday
      f.input :activated
      f.input :start_time_am
      f.input :end_time_am
      f.input :start_time_pm
      f.input :end_time_pm
    end
    f.actions
  end

  permit_params :name, :id, :siret, :address, :city, :postcode, :latitude, :longitude, :open_monday, :open_tuesday, :open_wednesday, :open_thursday, :open_friday, :open_saturday, :open_sunday, :activated, :start_time_am, :end_time_am, :start_time_pm, :end_time_pm

end

ActiveAdmin.register Company do

  index do
    selectable_column
    column :name
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
    column :user_id
    column :open_monday
    column :open_tuesday
    column :open_wednesday
    column :open_thursday
    column :open_friday
    column :open_saturday
    column :open_sunday
    column :open_holiday
    column :start_time_am
    column :end_time_am
    column :start_time_pm
    column :end_time_pm
  end

end

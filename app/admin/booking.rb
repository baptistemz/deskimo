ActiveAdmin.register Booking do

  index do
    selectable_column
    column :start_date_time
    column :end_date_time
    column :desk_id
    column :user_id
    actions
  end

  form do |f|
    f.inputs "Bookings" do
      f.input :start_date_time
      f.input :end_date_time
      f.input :desk_id
      f.input :user_id
    end
    f.actions
  end

  permit_params :start_date_time, :end_date_time, :desk_id, :user_id

end

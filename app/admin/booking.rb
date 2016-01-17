ActiveAdmin.register Booking do

  index do
    selectable_column
    column :start_date
    column :end_date
    column :desk_id
    column :user_id
    column :time_slot_quantity
    column :time_slot_type
    column :status
    column :amount
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Bookings" do
      f.input :start_date
      f.input :end_date
      f.input :desk_id
      f.input :user_id
      column :time_slot_quantity
      column :time_slot_type
      column :status
      column :amount
    end
    f.actions
  end
  permit_params :start_date_time, :end_date_time, :desk_id, :user_id
end

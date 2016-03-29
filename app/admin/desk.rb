ActiveAdmin.register Desk do

  index do
    selectable_column
    column :description
    column :company
    column :quantity
    column :capacity
    column :number
    column :kind
    column :hour_price
    column :half_day_price
    column :daily_price
    column :weekly_price
    column :activated
    column :projector
    column :paperboard
    column :desktop
    column :tv
    column :call_conference
    column :calendar_id
    actions
  end

  form do |f|

    f.inputs "Desk" do
      f.input :description
      f.input :company_id
      f.input :quantity
      f.input :kind
      f.input :activated
      f.input :capacity
      f.input :number
      f.input :projector
      f.input :paperboard
      f.input :desktop
      f.input :tv
      f.input :call_conference
      f.input :calendar_id
    end

    f.inputs "Prices" do
      f.input :hour_price
      f.input :half_day_price
      f.input :daily_price
      f.input :weekly_price
    end

    f.actions
  end

  permit_params :description, :company_id, :quantity, :kind, :hour_price, :daily_price, :weekly_price, :activated

end

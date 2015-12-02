ActiveAdmin.register Desk do

  index do
    selectable_column
    column :description
    column :company_id
    column :quantity
    column :kind
    column :hour_price
    column :daily_price
    column :weekly_price
    column :activated
    actions
  end

  form do |f|

    f.inputs "Desk" do
      f.input :description
      f.input :company_id
      f.input :quantity
      f.input :kind
      f.input :activated
    end

    f.inputs "Prices" do
      f.input :hour_price
      f.input :daily_price
      f.input :weekly_price
    end

    f.actions
  end

  permit_params :description, :company_id, :quantity, :kind, :hour_price, :daily_price, :weekly_price, :activated

end

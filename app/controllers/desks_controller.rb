class DesksController < ApplicationController


  def index
    @company = Company.find(params[:company_id])
    @desks = @company.desks.where(activated: true)
    @open_space = @desks.where(kind: :open_space, activated: true)
    @closed_office = @desks.where(kind: :closed_office, activated: true)
    @meeting_room = @desks.where(kind: :meeting_room, activated: true)
    @opening_weekdays_range = @company.get_opening_weekdays_range
    @opening_hours_range = @company.get_opening_hours_range
    @booking = Booking.new
  end
end


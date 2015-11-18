class DesksController < ApplicationController
  def show
    @company = Company.find(params[:company_id])
    @open_space = @company.desks.where(kind: :open_space)
    @closed_office = @company.desks.where(kind: :closed_office)
    @meeting_room = @company.desks.where(kind: :meeting_room)
    @desk = Desk.find(params[:id])
  end
end

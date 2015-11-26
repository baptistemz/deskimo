class DesksController < ApplicationController
  def show
    @company = Company.find(params[:company_id])
    @desks = @company.desks.where(activated: true)
    @open_space = @desks.where(kind: :open_space)
    @closed_office = @desks.where(kind: :closed_office)
    @meeting_room = @desks.where(kind: :meeting_room)
    @desk = Desk.find(params[:id])
  end
end

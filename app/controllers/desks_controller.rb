class DesksController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @desks = @company.desks.where(activated: true)
    @open_space = @desks.where(kind: :open_space).first
    @closed_office = @desks.where(kind: :closed_office).first
    @meeting_room = @desks.where(kind: :meeting_room).first
  end
end


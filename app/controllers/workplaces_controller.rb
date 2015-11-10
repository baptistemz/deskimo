class WorkplacesController < ApplicationController

  def index
    @workplaces = Workplace.all
  end
  def show
    @workplaces = Workplace.find(params[:id])
  end
end

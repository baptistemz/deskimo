module Account

  class DesksController < Account::Base
    def new
      @company = Company.find(params[:company_id])
      @desk = @company.desks.build
    end

    def create
      @company = Company.find(params[:company_id])
      @desk = @company.desks.build(desk_params)
      if @desk.save
        flash[:notice] = "Le bureau a bien été enregistré."
        redirect_to account_company_desks_path(@company)
      else
        flash[:alert] = "Le bureau n'a pas pu être enregistré"
        render :new
      end
    end

    def index
      @company = Company.find(params[:company_id])
      @desks = @company.desks
      @open_space = @desks.where(kind: :open_space).first
      @seperate_office = @desks.where(kind: :closed_office).first
      @meeting_room = @desks.where(kind: :meeting_room).first
    end

    private

    def desk_params
      params.require(:desk).permit( :kind,
                                    :description,
                                    :quantity,
                                    :hour_price,
                                    :daily_price,
                                    :weekly_price)
    end
  end
end

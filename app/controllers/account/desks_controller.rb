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
        @company.update_activation
        flash[:notice] = "Le bureau a bien été enregistré."
        redirect_to account_company_desks_path(@company)
      else
        flash[:alert] = "Le bureau n'a pas pu être enregistré"
        render :new
      end
    end

    def index
      @desk = Desk.new
      @company = Company.find(params[:company_id])
      @desks = @company.desks
      @open_space = @desks.where(kind: :open_space).first
      @closed_office = @desks.where(kind: :closed_office).first
      @meeting_room = @desks.where(kind: :meeting_room).first
      @opening_weekdays_range = @company.get_opening_weekdays_range
      @opening_hours_range = @company.get_opening_hours_range
    end

    def edit
      @desk = Desk.find(params[:id])
      @company = @desk.company
      render 'new'
    end

    def update
      @company = Company.find(params[:company_id])
      @desk = Desk.find(params[:id])
      @desk.update(desk_params)
      @company.update_activation
      redirect_to account_company_desks_path(@company)
    end

    private

    def desk_params
      params.require(:desk).permit( :kind,
                                    :description,
                                    :quantity,
                                    :half_day_price,
                                    :daily_price,
                                    :weekly_price)
    end
  end
end

module Account
  class DesksController < Account::Base
    def new
      @company = Company.find(params[:company_id])
      @desk = @company.desks.build
    end

    def create
      @company = Company.find(params[:company_id])
      @desk = @company.desks.build(desk_params)
      unless @desk.kind == "open_space"
        @desk.number = @company.desks.where(kind: @desk.kind).length + 1
        @desk.capacity = @desk.quantity
        @desk.quantity = 1
      end
      if @desk.save
        @company.update_activation
        flash[:notice] = t('flashes.desk_registered')
        redirect_to account_company_desks_path(@company)
      else
        flash[:alert] = t('flashes.desk_not_registered')
        render :new
      end
    end

    def index
      @desk = Desk.new
      @company = Company.find(params[:company_id])
      @desks = @company.desks
      @opening_weekdays_range = @company.get_opening_weekdays_range
      @opening_hours_range = @company.get_opening_hours_range
    end

    def edit
      @desk = Desk.find(params[:id])
      @company = @desk.company
      render 'new'
    end

    def update
      @desk = Desk.find(params[:id])
      @company = @desk.company
      unless @desk.kind == "open_space"
        @desk.number = @company.desks.where(kind: @desk.kind).length + 1
        @desk.capacity = @desk.quantity
        @desk.quantity = 1
      end
      if @desk.update(desk_params)
        @company.update_activation
        redirect_to account_company_desks_path(@company)
      else
        flash[:alert] = t('flashes.desk_not_registered')
        render :edit
      end
    end

    private

    def desk_params
      params.require(:desk).permit( :kind,
                                    :description,
                                    :quantity,
                                    :half_day_price,
                                    :daily_price,
                                    :weekly_price,
                                    :desktop,
                                    :projector,
                                    :tv,
                                    :call_conference)
    end
  end
end

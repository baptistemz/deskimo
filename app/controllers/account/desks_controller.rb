module Account
  class DesksController < Account::Base

    before_action :set_company

    def new
      @desk = @company.desks.build
    end

    def create
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
      @desk = @company.desks.build
      @open_space = @company.desks.where(kind: :open_space)
      @closed_office = @company.desks.where(kind: :closed_office).order(:number)
      @meeting_room = @company.desks.where(kind: :meeting_room).order(:number)
      @opening_weekdays_range = @company.get_opening_weekdays_range
      @opening_hours_range = @company.get_opening_hours_range
    end

    def edit
      @desk = @company.desks.find(params[:id])
      render :new
    end

    def update
      @desk = @company.desks.find(params[:id])
      unless @desk.kind == "open_space"
        @desk.capacity = params[:desk][:quantity]
        @desk.quantity = 1
      end
      if @desk.update(desk_params)
        flash[:notice] = t('flashes.desk_registered')
        @company.update_activation
        redirect_to account_company_desks_path(@company)
      else
        flash[:alert] = t('flashes.desk_not_registered')
        render :new
      end
    end

    def destroy
      @desk = @company.desks.find(params[:id])
      if @desk.destroy
        flash[:notice] = t('flashes.desk_deleted')
        redirect_to account_company_desks_path(@company)
      else
        redirect_to :back
        flash[:alert] = t('flashes.desk_not_deleted')
      end
    end

    def archived_bookings
      @desk = @company.desks.find(params[:desk_id])
      @bookings = @desk.bookings.where(archived: true)
    end

    private

    def set_company
      @company = current_user.company
    end

    def desk_params
      params.require(:desk).permit( :kind,
                                    :description,
                                    :quantity,
                                    :capacity,
                                    :number,
                                    :projector,
                                    :paperboard,
                                    :desktop,
                                    :tv,
                                    :call_conference,
                                    :calendar_id,
                                    :hour_price,
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

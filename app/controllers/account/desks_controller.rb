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
        redirect_to new_account_company_desk_path(@company)
      else
        flash[:alert] = "Le bureau n'a pas pu être enregistré"
        render :new
      end
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

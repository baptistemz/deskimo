module Account
  class CompaniesController < Account::Base
    def new
      if current_user.company
        flash[:alert] = t('company_creation.already_have_company')
        redirect_to(:back)
      else
        @company = current_user.build_company
      end
    end

    def create
      @company = current_user.build_company(company_params)
      @company.activated = false
      if @company.save
        # current_user.create_or_update_wallet
        flash[:notice] = t('flashes.company_registered')
        redirect_to new_account_company_desk_path(@company)
      else
        flash[:alert] = t('flashes.company_not_registered')
        render :new
      end
    end

    def edit
      @company = current_user.company
      render :new
    end

    def update
      @company = current_user.company
      @company.update(company_params)
      redirect_to account_company_desks_path(@company)
    end

    private

    def company_params
      params.require(:company).permit(:name,
                                      :description,
                                      :address,
                                      :city,
                                      :postcode,
                                      :phone_number,
                                      :siret,
                                      :coffee,
                                      :wifi,
                                      :printer,
                                      :picture,
                                      :open_monday,
                                      :open_tuesday,
                                      :open_wednesday,
                                      :open_thursday,
                                      :open_friday,
                                      :open_saturday,
                                      :open_sunday,
                                      :start_time_am,
                                      :end_time_am,
                                      :start_time_pm,
                                      :end_time_pm)

    end
  end
end

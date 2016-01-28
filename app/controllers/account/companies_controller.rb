module Account
  class CompaniesController < Account::Base
    def new
      @company = current_user.build_company
    end

    def create
      @company = current_user.build_company(company_params)
      @company.activated = false
      if @company.save
        # current_user.create_or_update_wallet
        flash[:notice] = "Votre entreprise a bien été enregistrée."
        redirect_to new_account_company_desk_path(@company)
      else
        flash[:alert] = "Votre entreprise n'a pas pu être enregistrée"
        render :new
      end
    end

    def edit
      @company = Company.find(params[:id])
      render 'new'
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

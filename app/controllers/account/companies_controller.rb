module Account
  class CompaniesController < Account::Base
    def new
      @company = current_user.build_company
    end

    def create
      @company = current_user.build_company(company_params)
      if @company.save
        current_user.create_or_update_wallet
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
                                      :siret,
                                      :address,
                                      :city,
                                      :postcode,
                                      :coffee,
                                      :wifi,
                                      :printer,
                                      :picture)
    end
  end
end

module CompanyAccount
  class DesksController
    def show
      @desk = Desk.find(params[:id])
    end
  end
end

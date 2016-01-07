module Account
  module Desks
    class ActivationController < Account::Base
      def create
        desk = Desk.find(params[:desk_id])
        desk.update(activated: true)
        desk.company.update_activation
        redirect_to account_company_desks_path(desk.company)
      end

      def destroy
        desk = Desk.find(params[:desk_id])
        desk.update(activated: false)
        desk.company.update_activation
        redirect_to account_company_desks_path(desk.company)
      end
      # private

      # # def set_desk
      # #   raise
      # # end
    end
  end
end

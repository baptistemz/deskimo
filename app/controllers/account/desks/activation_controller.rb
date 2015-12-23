module Account
  module Desks
    class ActivationController < Account::Base
      def create
        desk = Desk.find(params[:desk_id])
        desk.update(activated: true)
        redirect_to account_company_desks_path(desk.company)
        desk.company.update_activation
      end

      def destroy
        desk = Desk.find(params[:desk_id])
        desk.update(activated: false)
        redirect_to account_company_desks_path(desk.company)
        desk.company.update_activation
      end
      # private

      # # def set_desk
      # #   raise
      # # end
    end
  end
end

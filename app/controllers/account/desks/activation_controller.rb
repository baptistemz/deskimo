module Account
  module Desks
    class ActivationController < Account::Base
      before_action :set_desk

      def create
         @desk.update(activated: true)
         @desk.company.update_activation
        redirect_to account_company_desks_path(@desk.company)
      end

      def destroy
        @desk.update(activated: false)
        @desk.company.update_activation
        redirect_to account_company_desks_path(@desk.company)
      end
      private

      def set_desk
        @desk = Desk.find(params[:desk_id])
      end
    end
  end
end

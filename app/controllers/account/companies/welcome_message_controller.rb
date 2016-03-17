module Account
  module Companies
    class WelcomeMessageController < Account::Base
      before_action :set_company
      def new
        @welcome_message = @company.build_welcome_message
      end

      def create
        @welcome_message = @company.build_welcome_message(welcome_message_params)
        if @welcome_message.save
          flash[:notice] = t('flashes.welcome_message_recorded')
          redirect_to account_company_desks_path(@company)
        else
          flash[:alert] = t('flashes.welcome_message_not_recorded')
          render :new
        end
      end

      def edit
        @welcome_message = @company.welcome_message
        render :new
      end

      def update
        @welcome_message = @company.welcome_message
        @welcome_message.update(welcome_message_params)
        redirect_to account_company_desks_path(@company)
      end

      private

      def set_company
        @company = current_user.company
      end

      def welcome_message_params
        params.require(:welcome_message).permit(:wifi_name,
                                                :wifi_password,
                                                :message,
                                                :additional_information,
                                                :access_information)
      end

    end
  end
end

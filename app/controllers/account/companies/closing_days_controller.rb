module Account
  module Companies
    class ClosingDaysController < Account::Base
      before_action :set_company
      def index
        @closing_day = @company.closing_days.build
        @closing_days = @company.closing_days.where("closing_days.date IS NOT NULL")
      end

      def create
        d = params[:closing_day]
        @date = Date.new d["date(1i)"].to_i, d["date(2i)"].to_i, d["date(3i)"].to_i
        @closing_day = @company.closing_days.build(date: @date)
        @company.desks.each do |desk|
          desk.quantity.times do
            desk.unavailability_ranges.create(start_date: @date, end_date: @date)
          end
        end
        if @closing_day.save
          flash[:notice] = t('flashes.closing_saved')
          redirect_to account_company_closing_days_path(@company)
        else
          flash[:error] = t('flashes.impossible_action')
          redirect_to account_company_closing_days_path(@company)
        end
      end

      def destroy
        @closing_day = @company.closing_days.find(params[:id])
        @date = @closing_day.date
        @company.desks.each do |desk|
          desk.unavailability_ranges.where(start_date: @date, end_date: @date, kind: 'closed').destroy_all
        end
        if @closing_day.destroy
          flash[:notice] = t('flashes.closing_deleted')
          redirect_to account_company_closing_days_path(@company)
        else
          flash[:error] = t('flashes.impossible_action')
          redirect_to account_company_closing_days_path(@company)
        end
      end

      private

      def set_company
        @company = current_user.company
      end
    end
  end
end

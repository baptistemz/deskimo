module Account
  module Companies
    class ClosingDaysController < Account::Base
      before_action :set_company
      def index
        @closing_day = ClosingDay.new
        @closing_days = @company.closing_days
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
        @closing_day.save
        redirect_to account_company_closing_days_path(@company)
      end

      def destroy
        @date = params[:date]
        @company.desks.each do |desk|
          desk.unavailability_ranges.where(start_date: @date, end_date: @date, kind: 'closed').destroy_all
        end
      end

      private

      def set_company
        @company = Company.find(params[:company_id])
      end
    end
  end
end

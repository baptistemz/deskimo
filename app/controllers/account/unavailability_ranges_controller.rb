module Account
  class UnavailabilityRangesController < Account::Base
    before_action :set_company_desk_and_ranges

    def index
      @unavailability_range = @desk.unavailability_ranges.build
      # @unavailability_range = @desk.unavailability_ranges.build
      # @unavailability_ranges = @desk.unavailability_ranges.where(kind: 'planned')$
    end

    def create
      @quantity = params[:quantity].to_i
      d = params[:unavailability_range]
      @start_date = Date.new d["start_date(1i)"].to_i, d["start_date(2i)"].to_i, d["start_date(3i)"].to_i
      @end_date = Date.new d["end_date(1i)"].to_i, d["end_date(2i)"].to_i, d["end_date(3i)"].to_i
      @quantity.times do |t|
        @desk.unavailability_ranges.create(start_date: @start_date, end_date: @end_date, kind: "planned")
      end
      redirect_to account_company_desk_unavailability_ranges_path(@company, @desk)
    rescue
      flash[:alert] = "Action impossible"
      render :index
      return
    end

    def destroy
      range = params[:id].split('/')
      @desk.unavailability_ranges.where(start_date: range[0], end_date: range[1]).destroy_all
      redirect_to account_company_desk_unavailability_ranges_path(@company, @desk)
    end

    private

    def set_company_desk_and_ranges
      @company = current_user.company
      @desk = @company.desks.find(params[:desk_id])
      @ranges = @desk.unavailability_ranges.where(kind: 'planned').group(:start_date, :end_date).count
      # @ranges = @desk.unavailability_ranges.where(kind: 'planned').select(:id,:start_date,:end_date).group(:id,:start_date,:end_date)
    end
  end
end

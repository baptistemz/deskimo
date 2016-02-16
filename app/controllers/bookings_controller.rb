class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @booking = current_user.bookings.build(booking_params)
    @booking.desk = Desk.find(params[:desk_id])
    @booking.set_amount_and_dates
    if @booking.save
      @unavailability = @booking.build_unavailability_range(
                                            desk: @booking.desk,
                                            kind: :booked,
                                            start_date: @booking.start_date,
                                            end_date: @booking.end_date
                                            )
      if @unavailability.save
        CleanUnpaidBookingsJob.set(wait: 20.minutes).perform_later(@booking.id)
        redirect_to company_desk_booking_confirmation_path(@booking.desk.company, @booking.desk, @booking )
      else
        @booking.update(status: 'canceled')
        flash[:alert] = "Bureau indisponible à ces dates"
        redirect_to(:back)
      end
    else
      flash[:alert] = 'Reservation impossible'
      redirect_to(:back)
    end
  end

  def confirmation
    set_booking
    @user = current_user
  end

  private

  def set_booking
    @booking = current_user.bookings.find(params[:booking_id])
  rescue
    flash[:alert] = t('checkout.time_expiry')
    redirect_to root_path
  end

  def booking_params
    params.require(:booking).permit(:time_slot_quantity,
                                    :time_slot_type,
                                    :start_date,
                                    :half_day_choice)
  end
end

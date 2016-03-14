module Account
  module Bookings
    class ConfirmationController < Account::Base
      before_action :set_booking
      require "stripe"

      def show
        @company = @booking.desk.company
        @desk = @booking.desk
        # @booking = @desk.bookings.find(params[:booking_id])
        @user = @booking.user
      end

      def create
        @booking.update(status: :confirmed)
        redirect_to account_booking_confirmation_path(@booking)
      end

      def destroy
        raise
        refund = Stripe::Refund.create(
          charge: "ch_17owUg2eZvKYlo2Cwcmpe3op"
        )



        @booking.update(status: :canceled, refund: refund.to_json)
        # @booking.invoice.update(refund: refund.to_json)
        redirect_to account_booking_confirmation_path(@booking)

      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to account_booking_confirmation_path(@booking)
      end

      private

      def set_booking
        @booking = Booking.find(params[:booking_id])
      end
    end
  end
end

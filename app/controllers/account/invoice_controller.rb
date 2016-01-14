module Account
  class InvoiceController < ApplicationController
    def show
      @invoice = Booking.find(params[:booking_id]).invoice
      @booking = @invoice.booking
      @desk = @invoice.booking.desk
      @company = @invoice.booking.desk.company
      @user = @invoice.booking.user

      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "report", :layout => 'pdf.html.slim'
        end
      end
    end
  end
end

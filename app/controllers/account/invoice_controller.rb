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
          render :pdf => "invoice_#{@company.name.downcase.gsub(/\s+/, "")}_#{@invoice.created_at.strftime('%d_%m_%Y')}", :layout => 'pdf.html.slim'
        end
      end
    end
  end
end

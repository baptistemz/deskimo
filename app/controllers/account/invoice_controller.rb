module Account
  class InvoiceController < ApplicationController
    def show
      @invoice = Booking.find(params[:booking_id]).invoice
      respond_to do |format|
        format.html
        format.pdf do
          pdf = InvoicePdf.new(@invoice)
          send_data pdf.render, filename: '#{@invoice.booking.company.name)}_booking_#{@invoice.created_at.strftime(("%d_%m_%Y"))}.pdf', type: 'application/pdf'
        end
      end
    end
  end
end

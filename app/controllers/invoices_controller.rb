class InvoicesController < ApplicationController
	  # before_filter :authenticate_customer!, :only => [:index, :show]
	  

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, view_context)
        send_data pdf.render, filename: 
        "invoice_#{@invoice.created_at.strftime("%d/%m/%Y")}.pdf",
        type: "application/pdf", disposition: "inline"
      end
    end
  end

  def new
  	@invoice = Invoice.new
  	@invoice.build_from
  	@invoice.build_to
  	@invoice.lines.build
  end

  def edit
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to root_url, notice: 'Invoice was successfully created.'
    else
      render action: 'new'
    end
  end

  
  def update
    if @invoice.update(invoice_params)
      redirect_to root_url, notice: 'Invoice was successfully updated.' 
    else
      render action: 'edit' 
    end
  end

  
  def destroy
    @invoice.destroy
      redirect_to invoices_url
  end

  private

  def set_invoice
  	@invoice = Invoice.find(params[:id])
  end

	def invoice_params
		params.require(:invoice).permit(:number, :date_issued, :payment_due, :description, :payment_description, :total, :subtotal, :total_vat, :image, from_attributes: [:id, :name, :email, :more_info],
			to_attributes: [:id, :name, :email, :more_info], lines_attributes: [:id, :product_description, :unit, :unit_value, :quantity, :vat_value, :line_total, :_destroy])
	end
end
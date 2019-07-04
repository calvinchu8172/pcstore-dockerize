class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
    if @orders.count == 0
      flash[:notice] = I18n.t('order.no_order')
    end 
  end

  def show
    @order = Order.find( params[:id] ) 
  end

  def edit
    @order = Order.find( params[:id] )
  end

  def update
    @order = Order.find( params[:id] )
    if @order.update_attributes( order_params )
      redirect_to order_path(@order), success: I18n.t('order.update.success')
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:id, order_items_attributes: [:id, :quantity], receipt_attributes: [:name, :tel, :country, :city, :address])
  end

end
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, except: :index
  before_action :order_failed, only: :edit

  def index
    Order.check_user_order_item_available(current_user)

    @q = current_user.orders.ransack(params[:q])
    @data = @q.result(distinct: true)
    @orders = @data.page(params[:page]).per(20)
    
    if @orders.count == 0
      flash[:notice] = I18n.t('order.no_order')
    end 
  end

  def show
  end

  def edit
  end

  def update
    if @order.update_attributes( order_params )
      @order.sum = @order.total_price
      @order.save
      redirect_to order_path(@order), success: I18n.t('order.update.success')
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:id, order_items_attributes: [:id, :quantity], receipt_attributes: [:name, :tel, :country, :city, :address])
  end

  def find_order
    @order = Order.find( params[:id] )
  end

  def order_failed
    if @order.is_failed?
      redirect_to order_path(@order), danger: I18n.t('order.failed')
    end
  end

end
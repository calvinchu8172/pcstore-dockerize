class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, except: [:index, :search]
  before_action :check_order_items_available, only: [:show, :edit]
  before_action :order_failed?, only: :edit

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
    @order_item = OrderItem.new
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

  def search
    if params[:name]
      name = params[:name]
      @products = Product.where('LOWER(name) LIKE :name', name: "%#{name.downcase}%")
    elsif params[:id]
      product = Product.find_by(id: params[:id])
      if product
        @products = [] << product
      else
        @products = [] 
      end
    end    
    respond_to do |format|
      format.html
      format.json { @products }
    end
  end

  private

  def order_params
    params.require(:order).permit(:id, order_items_attributes: [:id, :quantity], receipt_attributes: [:name, :tel, :country, :city, :address])
  end

  def find_order
    @order = Order.find( params[:id] )
  end

  def check_order_items_available
    Order.check_order_items_available(@order)
  end

  def order_failed?
    if @order.failed?
      redirect_to order_path(@order), danger: I18n.t('order.failed')
    end
  end

end
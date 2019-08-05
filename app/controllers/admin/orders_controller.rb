class Admin::OrdersController < Admin::BaseController
  before_action :all_categroies

  def index
    @q = Order.ransack(params[:q])
    # @data = @q.result(distinct: true).includes(:user, :order_items)
    @data = @q.result.includes(:user, :order_items)
    @orders = @data.page(params[:page]).per(20)
    # @orders = Order.page(params[:page]).per(20)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @order.build_receipt
    2.times { @order.order_items.build }
    # @receipt = @order.receipt ||= Receipt.new
  end

  def create
    puts "********1 #{params}"
    puts "********2 #{order_params}"
    @order = Order.new(order_params)
    @order.sum = @order.total_price
    @order.order_items.each do |item|
      item.product_price = item.product.price
    end
    if @order.save
      redirect_to admin_order_path(@order), success: I18n.t('order.build.success')
    else
      render :new, danger: I18n.t('order.build.failed')
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      redirect_to admin_orders_path, success: I18n.t('order.destroy.success')
    else
      redirect_to admin_orders_path, danger: I18n.t('order.destroy.failed')
    end
  end

  private

  def order_params
    params.require(:order).permit(:id, :user_id, :sum, order_items_attributes: [:id, :product_id, :product_name, :quantity, :product_price, :_destroy], receipt_attributes: [:name, :tel, :country, :city, :address])
  end

  def all_categroies
    @categories = Category.all
  end

end

class Admin::OrdersController < Admin::BaseController
  before_action :all_categroies
  before_action :find_order, only: [:show, :edit, :update, :destroy]

  def index
    @q = Order.ransack(params[:q])
    @data = @q.result(distinct: true).includes(:user, :order_items)
    @orders = @data.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @order = Order.new
    @order.build_receipt
    2.times { @order.order_items.build }
  end

  def create
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

  def edit
  end

  def update
    if @order.update_attributes(order_params)
      @order.sum = @order.total_price
      @order.order_items.each do |item|
        item.product_price = item.product.price
      end
      @order.save
      redirect_to admin_order_path(@order), success: I18n.t('order.update.success')
    else
      render :edit, danger: I18n.t('order.update.failed')
    end
  end

  def destroy
    if @order.destroy
      redirect_to admin_orders_path, success: I18n.t('order.destroy.success')
    else
      redirect_to admin_orders_path, danger: I18n.t('order.destroy.failed')
    end
  end

  private

  def order_params
    params.require(:order).permit(:id, :user_id, :sum, :state, order_items_attributes: [:id, :product_id, :product_name, :quantity, :product_price, :_destroy], receipt_attributes: [:name, :tel, :country, :city, :address])
  end

  def all_categroies
    @categories = Category.all
  end

  def find_order
    @order = Order.find(params[:id])
  end

end

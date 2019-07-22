class Admin::OrdersController < Admin::BaseController
  before_action :all_categroies

  def index
    @q = Order.ransack(params[:q])
    # @data = @q.result(distinct: true).includes(:user, :order_items)
    @data = @q.result.includes(:user, :order_items)
    @orders = @data.page(params[:page]).per(20)
    # @orders = Order.page(params[:page]).per(20)
  end

  private

  def all_categroies
    @categories = Category.all
  end

end

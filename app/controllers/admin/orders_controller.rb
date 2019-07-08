class Admin::OrdersController < Admin::BaseController
  before_action :all_categroies

  def index
    @orders = Order.page(params[:page]).per(20)
  end

  private

  def all_categroies
    @categories = Category.all
  end

end

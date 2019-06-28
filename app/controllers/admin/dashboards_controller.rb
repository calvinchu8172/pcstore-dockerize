class Admin::DashboardsController < Admin::BaseController

  def index
    @categories = Category.all
  end
end

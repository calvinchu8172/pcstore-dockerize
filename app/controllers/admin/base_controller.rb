class Admin::BaseController < ApplicationController
  before_action :require_admin

  layout 'admin'

  private
  def require_admin
    redirect_to root_path, notice: '權限不足' unless current_user.is_admin?
  end
end

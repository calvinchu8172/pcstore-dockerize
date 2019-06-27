class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  layout 'admin'

  private
  def require_admin
    redirect_to root_path, warning: I18n.t('no_authority') unless current_user.is_admin?
  end
end

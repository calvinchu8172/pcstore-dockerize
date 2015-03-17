class UsersController < ApplicationController

  def set_admin
    @user = current_user
    @user.admin = true
    @user.save
    redirect_to :back
  end

  def remove_admin
    @user = current_user
    @user.admin = false
    @user.save
    redirect_to :back
  end  

  private
  def user_params
    params.require(:user).permit(:admin)
  end

end

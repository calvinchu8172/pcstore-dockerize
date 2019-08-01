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

  def search
    if params[:email]
      email = params[:email]
      @users = User.where('LOWER(email) LIKE :email', email: "%#{email.downcase}%")
    elsif params[:id]
      user = User.find_by(id: params[:id])
      if user
        @users = [] << user
      else
        @users = [] 
      end
    end    
    respond_to do |format|
      format.html
      format.json { @users }
    end
  end  

  private

  def user_params
    params.require(:user).permit(:admin)
  end

end

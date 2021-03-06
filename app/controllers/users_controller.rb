class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = params[:user] ? User.new(user_params) : User.new_guest
    if @user.save
      current_user.move_to(@user) if current_user && current_user.guest?
      session[:user_id] = @user.id
      flash[notice] = "Sign up successfully!" unless current_user.guest?
      redirect_to root_path
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end

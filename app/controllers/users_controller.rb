class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = params[:user] ? User.new(user_params) : User.new_guest
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Sign up successfully!"
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email)
    end
end

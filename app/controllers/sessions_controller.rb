class SessionsController < ApplicationController
  layout 'users'

  def new
  end

  def create
    user = User.find_by_username(params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'login successfully!'
    else
      flash.now.alert = "Name or password is invalid"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, alert: 'Logout successfully!'
  end

  private

    def user_params
      #code
    end
end

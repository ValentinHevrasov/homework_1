class SessionsController < ApplicationController
  def new
  end

  def index
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Вошли"
    else
      flash.now.alert = "Email или пароль введен не верно"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Вышли!"
  end
end

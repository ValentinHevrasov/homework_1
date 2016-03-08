class UsersController < ApplicationController

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to root_url, notice: "Вы вошли!"
    else
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  end

end

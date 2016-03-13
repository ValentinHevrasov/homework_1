class PetitionsController < ApplicationController
  # before_filter :authorize, only: [:edit, :update]

  def index
    @petition = Petition.all
    @petition = @petition.where(user: current_user) if params[:my]
  end

  def show
    @petition = Petition.find(params[:id])
  end

  def new
  end

  def create
    @petition = Petition.new(petition_params)
    @petition.user_id = current_user.id
    @petition.save
    redirect_to @petition, notice: "Петиция добавлена"
  end

  def petition_name
    @petition.user.name
  end

  private
  def petition_params
    params.require(:petition).permit(:id, :title, :text)
  end
end

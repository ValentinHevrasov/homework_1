class PetitionsController < ApplicationController
  before_filter :authorize_user, only: [:edit, :update]

  def index
    @petition = Petition.all
    @petition = @petition.where(user: current_user) if params[:my]
  end

  def show
    @petition = Petition.find(params[:id])
  end

  def new
  end

  def edit
    @petition = Petition.find(params[:id])
  end

  def create
    @petition = Petition.create(petition_params)
    @petition.user_id = current_user.id
    @petition.save
    # UserMailer.petition_created(@petition).deliver_now
    UserMailer.petition_created(@petition).deliver_later
    
# UserMailer.admin_votes(@petition).deliver_later
# UserMailer.votes_good(@petition).deliver_later
# UserMailer.votes_bad(@petition).deliver_later

    Rails.logger.info 'After mailer'
    redirect_to @petition, notice: "Петиция добавлена"
  end

  def update
    @petition = Petition.find(params[:id])
    if @petition.update(petition_params)
      redirect_to @petition, notice: "Петиция обновлена"
    else
      render 'edit'
    end
  end

  def petition_name
    @petition.user.name
  end

  def destroy
    @petition = Petition.find(params[:id])
    @petition.destroy
    params[:my] = true
    redirect_to root_path, notice: "Петиция удалена"
  end

  private
  def petition_params
    params.require(:petition).permit(:id, :title, :text)
  end
end

class UsersController < ApplicationController
  # 1. Il faut être connecté pour voir une page profil
  before_action :authenticate_user!

  # 2. Il faut être sur SA propre page
  before_action :ensure_correct_user, only: [:show]

  def show
    @user = User.find(params[:id])
    @created_events = @user.events.order(start_date: :asc)
  end

  private

  # Empêche un user d’aller sur le profil d’un autre
  def ensure_correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_path, alert: t("app.flash.profile_forbidden")
    end
  end
end
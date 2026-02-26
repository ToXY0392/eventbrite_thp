class AvatarsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])

    # optionnel mais sain : empêcher de changer l'avatar d'un autre
    unless current_user == @user
      redirect_to root_path, alert: t("app.flash.profile_forbidden", default: "Tu ne peux pas modifier ce profil.") and return
    end

    @user.avatar.attach(params[:avatar])
    redirect_to user_path(@user),
                notice: t("app.flash.avatar_updated", default: "Avatar mis à jour.")
  end
end
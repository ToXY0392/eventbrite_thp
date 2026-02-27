# frozen_string_literal: true

module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = User.order(created_at: :desc)
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_user_path(@user), notice: t("app.admin.user.created")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: t("app.admin.user.updated")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: t("app.admin.user.destroyed")
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      p = params.require(:user).permit(:email, :first_name, :last_name, :description, :is_admin, :password, :password_confirmation)
      p.delete(:password) if p[:password].blank?
      p.delete(:password_confirmation) if p[:password_confirmation].blank?
      p
    end
  end
end

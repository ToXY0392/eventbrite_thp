# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_admin

    private

    def check_if_admin
      return if current_user&.admin?

      redirect_to root_path, alert: t("app.admin.forbidden")
    end
  end
end

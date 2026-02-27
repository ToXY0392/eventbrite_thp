# frozen_string_literal: true

module Admin
  class EventSubmissionsController < BaseController
    before_action :set_event, only: [:show, :edit, :update]

    def index
      @events = Event.pending_validation.order(created_at: :asc)
    end

    def show
    end

    def edit
    end

    def update
      validated_flag = params[:validated] == "true"
      @event.update!(validated: validated_flag, reviewed: true)

      if validated_flag
        UserMailer.event_validated_email(@event.admin, @event).deliver_now
        redirect_to admin_event_submissions_path, notice: t("app.admin.event_submission.validated")
      else
        UserMailer.event_rejected_email(@event.admin, @event).deliver_now
        redirect_to admin_event_submissions_path, notice: t("app.admin.event_submission.rejected")
      end
    end

    private

    def set_event
      @event = Event.pending_validation.find(params[:id])
    end
  end
end

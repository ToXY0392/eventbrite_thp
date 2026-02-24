class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @attendance = Attendance.new(user: current_user, event: @event)

    if @attendance.save
      redirect_to @event, notice: t("app.flash.attendance_created")
    else
      redirect_to @event, alert: @attendance.errors.full_messages.join(", ")
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end

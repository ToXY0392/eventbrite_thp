class AttendanceMailer < ApplicationMailer
  def new_attendance(attendance)
    @attendance  = attendance
    @event       = attendance.event
    @admin       = @event.admin
    @participant = attendance.user

    mail(
      to: @admin.email,
      subject: "Nouvelle inscription à ton événement : #{@event.title}"
    )
  end
end
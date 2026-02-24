class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id, message: "est déjà inscrit à cet événement" }

  after_create :notify_event_admin

  private

  def notify_event_admin
    AttendanceMailer.new_attendance(self).deliver_now
  end
end
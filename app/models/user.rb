class User < ApplicationRecord
  # Associations
  has_many :attendances, dependent: :destroy
  has_many :events_attended, through: :attendances, source: :event

  has_many :events,
            foreign_key: 'admin_id',
            class_name: 'Event',
            dependent: :destroy

  # Validations
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :encrypted_password,
            presence: true

  validates :first_name, presence: true
  validates :last_name,  presence: true

  # Mailer callback (sera activé quand les mailers seront faits)
  after_create :welcome_send

  private

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
class User < ApplicationRecord
  # Devise modules
  # (on reste sur le combo classique pour THP : login, signup, reset password, remember me, validations)
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Associations Eventbrite
  has_many :events, foreign_key: :admin_id, class_name: "Event", dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :attended_events, through: :attendances, source: :event

  # 🔹 Active Storage : avatar
  has_one_attached :avatar

  # Mailer de bienvenue (vu hier)
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  
  # 🔹 Retourne l'avatar uploadé ou une image par défaut (random fixe par utilisateur, comme demandé par THP)
  def admin?
    is_admin
  end

  def avatar_or_default
    return avatar if avatar.attached?

    # Photo de profil "random" : déterministe selon l'id pour rester cohérent
    "avatars/default_#{(id || rand(1..3)) % 3 + 1}.png"
  end
end
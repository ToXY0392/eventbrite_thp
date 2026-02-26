class Event < ApplicationRecord
  # Associations
  belongs_to :admin, class_name: 'User'
  has_many :attendances, dependent: :destroy
  has_many :participants, through: :attendances, source: :user

  # Active Storage : photo de l'événement (optionnelle pour le seed)
  has_one_attached :picture

  # Validations
  validates :start_date, presence: true
  validate  :start_date_cannot_be_in_the_past

  validates :duration,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validate :duration_multiple_of_5

  validates :title,
            presence: true,
            length: { in: 5..140 }

  validates :description,
            presence: true,
            length: { in: 20..1000 }

  validates :price,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 1000
            }

  validates :location,
            presence: true

  def is_free?
    price == 0
  end

  def end_date
    start_date + duration.minutes
  end

  private

  def start_date_cannot_be_in_the_past
    return if start_date.blank?

    errors.add(:start_date, "ne peut pas être dans le passé") if start_date < Time.current
  end

  def duration_multiple_of_5
    return if duration.blank?

    errors.add(:duration, "doit être un multiple de 5") unless duration % 5 == 0
  end
end
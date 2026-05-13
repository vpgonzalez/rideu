class Trip < ApplicationRecord
  belongs_to :user

  enum :status, { active: 0, full: 1, cancelled: 2, completed: 3 }

  validates :origin, presence: true
  validates :destination, presence: true
  validates :departure_time, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_blank: false
  validates :available_seats, numericality: { greater_than: 0 }, allow_blank: false

  scope :available, -> { where(status: :active) }
  scope :by_university, ->(uni) { where(university: uni) }
end
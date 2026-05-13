class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  enum :status, { pending: 0, confirmed: 1, cancelled: 2 }

  validates :user_id, uniqueness: { scope: :trip_id }
end
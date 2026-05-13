class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { passenger: 0, driver: 1 }

  has_one :vehicle, dependent: :destroy
  has_many :trips, dependent: :destroy

  has_many :reservations, dependent: :destroy
  has_many :reserved_trips, through: :reservations, source: :trip

  validates :university, presence: true
  validates :phone, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
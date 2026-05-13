class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { passenger: 0, driver: 1 }

  has_one :vehicle, dependent: :destroy
  has_many :trips, dependent: :destroy

  validates :university, presence: true
  validates :phone, presence: true
end

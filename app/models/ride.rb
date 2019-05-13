class Ride < ApplicationRecord
  enum status: { created: 0, started: 1, completed: 2, cancelled: 3 }

  validates :token, presence: true
  validates :token, uniqueness: true
  validates :token, format: { with: /\A[a-zA-Z0-9]{4}\z/ }
  validates :status, presence: true

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token = loop do
      random_token = SecureRandom.hex(2)
      break random_token unless self.class.exists?(token: random_token)
    end
  end

end

class Ride < ApplicationRecord
  enum status: { created: 0, started: 1, completed: 2, cancelled: 3 }

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token = loop do
      random_token = SecureRandom.hex(2)
      break random_token unless self.class.exists?(token: random_token)
    end
  end
  
end

class Ride < ApplicationRecord
  enum status: { created: 0, started: 1, completed: 2, cancelled: 3 }

end

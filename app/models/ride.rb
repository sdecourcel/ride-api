class Ride < ApplicationRecord
  enum status: { created: 0, started: 1, completed: 2, cancelled: 3 }

  validates :token, presence: true
  validates :token, uniqueness: true
  validates :token, format: { with: /\A[a-zA-Z0-9]{4}\z/ }
  validates :status, presence: true

  before_validation :generate_token, on: :create

  def generate_bill
    unless created?
      errors.add(:status, "Impossible de générer une facture pour un trajet n'ayant pas le statut 'créé' ")
      return false
    end
    unless payment_service.bill
      errors.add(:status, "Echec de la facturation")
      return false
    end
    started!
  end

  def proceed_payment
    unless started?
      errors.add(:status, "Impossible de procéder au paiement pour un trajet n'ayant pas le statut 'démarré' ")
      return false
    end
    unless payment_service.pay
      errors.add(:status, "Echec du paiement")
      return false
    end
    completed!
  end

  def proceed_reimburse
    unless completed?
      errors.add(:status, "Impossible de procéder au remboursement pour un trajet n'ayant pas le statut 'terminé' ")
      return false
    end
    unless payment_service.reimburse
      errors.add(:status, "Echec du remboursement")
      return false
    end
    cancelled!
  end

  def explicit_status
    case status
    when "created" then "Créé"
    when "started" then "Démarré"
    when "completed" then "Terminé"
    when "cancelled" then "Annulé"
    else "Erreur: aucun statut trouvé pour ce trajet"
    end
  end

  private

  def generate_token
    self.token = loop do
      random_token = SecureRandom.hex(2)
      break random_token unless self.class.exists?(token: random_token)
    end
  end

  def payment_service
    PaymentService.new(ride: self)
  end
end

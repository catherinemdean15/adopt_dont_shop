class Shelter < ApplicationRecord
  has_many :pets


  def self.pending_applications
    joins(pets: :pet_applications)
        .where(pet_applications: {status: "Pending"})
        .distinct
        .order(:name)
  end

end

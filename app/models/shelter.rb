class Shelter < ApplicationRecord
  has_many :pets


  def self.pending_applications
    joins(pets: :pet_applications)
        .where(pet_applications: {status: "Pending"})
        .distinct
        .order(:name)
  end

  def average_pet_age
    self.pets.average(:approximate_age)
  end

  def adoptable_number(boolean)
    pets.where(adoptable: boolean).count
  end

  def pets_pending
    
  end

end

class Shelter < ApplicationRecord
  has_many :pets


  def self.pending_applications
    joins(pets: :pet_applications)
        .where(pet_applications: {status: "Pending"})
        .distinct
        .order(:name)
  end

  def average_pet_age
    #self.pets.average(:age)
  end

  def number_adopted
    pets.where(adoptable: false).count
  end

end

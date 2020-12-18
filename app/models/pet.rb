class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  validates_presence_of :name, :description, :approximate_age, :sex

  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }

  enum sex: [:female, :male]


  def adoption_status
    if Application.joins(:petapplications).where('petapplications.pet_id = self.id, applications.status = "Approved", petapplications.status = "Approved"')
      self.update({
        adoptable: false
        })
    end
  end

end

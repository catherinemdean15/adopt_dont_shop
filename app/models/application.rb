class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zip


  def pet_status(pet_id, application_id)
    PetApplication.find_by(pet_id: pet_id, application_id: application_id).status
  end

  def app_status
    if (PetApplication.where(application_id: self.id, status: "Approved").count) == (PetApplication.where(application_id: self.id).count)
      self.update({
        status: "Approved"
        })
    elsif (PetApplication.where(application_id: self.id, status: "Rejected").count) >= 1
      self.update({
        status: "Rejected"
        })
    end
  end


end

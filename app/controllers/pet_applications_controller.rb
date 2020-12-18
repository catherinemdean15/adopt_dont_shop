class PetApplicationsController < ApplicationController

  def create
    if params[:commit] == "Add pet"
      @pet = Pet.find(params[:pet_id])
      @application = Application.find(params[:id])
      @pet_application = PetApplication.create!(pet_id: @pet.id, application_id: @application.id, status: "Pending")
      redirect_to "/applications/#{@application.id}"
    end
  end

end

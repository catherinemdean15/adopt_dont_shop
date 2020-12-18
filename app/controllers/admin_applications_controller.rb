class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    @pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
    @pet = Pet.find(params[:pet_id])
    if params[:commit] == "Approve"
          @pet_application.update({
          status: "Approved"
          })
    elsif params[:commit] == "Reject"
        @pet_application.update({
          status: "Rejected"
          })
    end
    @application.app_status
    @pet.adoption_status
    redirect_to "/admin/applications/#{params[:id]}"
  end

end

class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
      application = Application.new(application_params)
      application[:status] = "In Progress"
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "All fields must be completed"
      render :new
    end
  end


  def update
    @application = Application.find(params[:id])
    @pet = Pet.where(name: params[:pet_name])
    @application.update({
          pets: @pet,
        })
      @application.save
      redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end
end

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
      @application = Application.new(application_params)
      @application[:status] = "In Progress"
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash.now[:notice] = "All fields must be completed"
      render :new, action: @application
    end
  end


  def update
    @application = Application.find(params[:id])
    if params[:pet_name]
      @pets = Pet.partial_match(params[:pet_name], "name")
      render :show
    elsif params[:description]
      @application.update({
        status: "Pending",
        description: params[:description]
        })
      redirect_to "/applications/#{@application.id}"
    end
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end
end

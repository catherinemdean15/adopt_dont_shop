class ApplicationsController < ActionController::Base
  def show
    @application = Application.find(params[:id])
  end
end

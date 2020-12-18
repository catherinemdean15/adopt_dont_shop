class AddStatusToPetsApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pets_applications, :status, :string
  end
end

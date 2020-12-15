class CreatePetsApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pets_applications do |t|
      t.integer :pet_id
      t.integer :application_id

      t.timestamps
    end
  end
end

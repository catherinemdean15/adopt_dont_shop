require 'rails_helper'

RSpec.describe 'Admin shelter index page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet3 = @shelter1.pets.create!(image:"", name: "Thorny", description: "dog", approximate_age: 4, sex: "male")
    @pet2 = @shelter2.pets.create!(image:"", name: "Dog3", description: "dog", approximate_age: 4, sex: "male")
    @application1 = create(:application, status: "In Progress")
    @application2 = create(:application, status: "In Progress")
    @pet_application1 = PetApplication.create!(pet_id: @pet1.id, application_id: @application1.id, status: "Pending")
    @pet_application2 = PetApplication.create!(pet_id: @pet1.id, application_id: @application2.id, status: "Pending")

  end

  it "lists all shelters in reverse alphabetical" do
    visit "/admin/shelters"

      expect(page.all('#shelters')[0]).to have_content("Silly Shelter")
      expect(page.all('#shelters')[1]).to have_content("Shady Shelter")
  end

  it "has a section for Shleters with Pending Applications" do
    visit "/admin/shelters"

    within('#pending') do
      expect(page).to have_content(@shelter1.name)
      expect(page).to have_no_content(@shelter2.name)
    end
  end

  it "the section for Shleters with Pending Applications is alphabetical" do
    @pet_application3 = PetApplication.create!(pet_id: @pet2.id, application_id: @application1.id, status: "Pending")

    visit "/admin/shelters"

      expect(page.all('#shelters')[0]).to have_content("Silly Shelter")
      expect(page.all('#shelters')[1]).to have_content("Shady Shelter")

  end

  it "the section for Shleters links each shelter name with the show page" do

    visit "/admin/shelters"

      expect(page).to have_link(@shelter1.name)
      click_link "#{@shelter1.name}"
      expect(page).to have_current_path("/shelters/#{@shelter1.id}")

  end
end

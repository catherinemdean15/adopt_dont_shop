require 'rails_helper'

RSpec.describe 'Admin shelter show page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet3 = @shelter1.pets.create!(image:"", name: "Thorny", description: "dog", approximate_age: 4, sex: "male")
    @application1 = create(:application, status: "In Progress")
    @application2 = create(:application, status: "Pending")
    @pet_application1 = PetApplication.create!(pet_id: @pet1.id, application_id: @application1.id, status: "Pending")
    @pet_application2 = PetApplication.create!(pet_id: @pet1.id, application_id: @application2.id, status: "Pending")
  end

  it "lists all shelters in reverse alphabetical" do
    visit "/admin/shelters/#{@shelter1.id}"

      expect(page).to have_content(@shelter1.name)
      expect(page).to have_content(@shelter1.address)
      expect(page).to have_content(@shelter1.city)
      expect(page).to have_content(@shelter1.state)
      expect(page).to have_content(@shelter1.zip)
  end

  it "has a statistics section with average pet age" do
    visit "/admin/shelters/#{@shelter1.id}"

    expect(page).to have_content("Statistics")

    within("#statistics") do
    expect(page).to have_content(@shelter1.average_pet_age)
    end
  end

  it "has a statistics section with count of adopted pets" do
    visit "/admin/shelters/#{@shelter1.id}"

    expect(page).to have_content("Statistics")

    within("#statistics") do
    expect(page).to have_content(@shelter1.adoptable_number(false))
    end
  end

  it "has a statistics section with count of adoptable pets" do
    visit "/admin/shelters/#{@shelter1.id}"

    expect(page).to have_content("Statistics")

    within("#statistics") do
    expect(page).to have_content(@shelter1.adoptable_number(true))
    end
  end

  it "has an action required section with list of pending pets" do
    visit "/admin/shelters/#{@shelter1.id}"
    expect(page).to have_content("Action Required")

    within("#action_required") do
    expect(page).to have_content(@pet1.name)
    expect(page).to have_link(@pet1.name)
  
    end
  end

end

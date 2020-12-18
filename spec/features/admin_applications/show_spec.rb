require 'rails_helper'

RSpec.describe 'Admin application show page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet3 = @shelter1.pets.create!(image:"", name: "Thorny", description: "dog", approximate_age: 4, sex: "male")
    @application1 = create(:application, status: "In Progress")
    @application2 = create(:application, status: "In Progress")
    @pet_application1 = PetApplication.create!(pet_id: @pet1.id, application_id: @application1.id, status: "Pending")
    @pet_application2 = PetApplication.create!(pet_id: @pet1.id, application_id: @application2.id, status: "Pending")
  end

  it "approves a pet on an application" do

    visit "/admin/applications/#{@application1.id}"

    expect(page).to have_button("Approve")
    click_button "Approve"
    expect(page).to have_content("Approved!")
    expect(page).to have_no_button("Approve")
  end

  it "rejects a pet on an application" do

    visit "/admin/applications/#{@application2.id}"
    expect(page).to have_button("Reject")
    click_button "Reject"

    expect(page).to have_content("Rejected!")
    expect(page).to have_no_button("Reject")
  end

  it "doesn't affect other applications" do

    visit "/admin/applications/#{@application1.id}"

    expect(page).to have_button("Approve")
    click_button "Approve"
    expect(page).to have_content("Approved!")
    expect(page).to have_no_button("Approve")

    visit "/admin/applications/#{@application2.id}"
    expect(page).to have_button("Approve")
    expect(page).to have_button("Reject")
    expect(page).to have_no_content("Approved!")
  end

  it "changes the status when all pets are approved" do

    visit "/admin/applications/#{@application1.id}"

    expect(page).to have_button("Approve")
    click_button "Approve"
    expect(page).to have_content("Application Status: Approved")

  end

  it "changes the status when any pets are rejected" do

    visit "/admin/applications/#{@application1.id}"

    expect(page).to have_button("Reject")
    click_button "Reject"
    expect(page).to have_content("Application Status: Rejected")

  end

  it "makes pets no longer adoptable" do

    visit "/admin/applications/#{@application1.id}"

    expect(page).to have_button("Approve")
    click_button "Approve"

    visit "/pets/#{@pet1.id}"
    expect(page).to have_content("Adoption Status: false")
  end

end

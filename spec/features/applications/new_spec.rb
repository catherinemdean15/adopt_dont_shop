require 'rails_helper'

RSpec.describe 'New application page', type: :feature do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet3 = @shelter1.pets.create!(image:"", name: "Thorny", description: "dog", approximate_age: 4, sex: "male")
    @application1 = create(:application, status: "In Progress")
  end

  it 'creates an application' do
    visit '/applications/new'

    fill_in 'Name', with: 'Name'
    fill_in 'Street address', with: '1234 Example St.'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80221'

    click_button 'Begin Application'
    expect(page).to have_content('Name')
    expect(page).to have_content('1234 Example St.')
    expect(page).to have_content('Denver')
    expect(page).to have_content('CO')
    expect(page).to have_content('80221')
  end

  it 'gives error when form is incomplete' do
    visit '/applications/new'
    fill_in 'Name', with: 'Example'
    click_button 'Begin Application'
    expect(page).to have_content("All fields must be completed")
    #expect(page).to have_content("Example")
  end

  it 'has a form to search pets by name' do

    visit "/applications/#{@application1.id}"

    expect(page).to have_field("Pet name")
    expect(page).to have_button("Search Pets")

    fill_in 'Pet name', with: 'tHor'
    click_button 'Search Pets'
    expect(page).to have_content('Thor')
    expect(page).to have_content('Thorny')
    expect(page).to have_button('Add pet')

  end

  it 'adds pets to application' do

    visit "/applications/#{@application1.id}"

    expect(page).to have_field("Pet name")
    expect(page).to have_button("Search Pets")

    fill_in 'Pet name', with: 'Thor'
    click_button 'Search Pets'
    expect(page).to have_content('Thor')
    expect(page).to have_button('Add pet')
    first(:button, "Add pet").click

    expect(page).to have_content('Thor')
    expect(page).to have_button("Search Pets")

  end

  it 'can submit application' do

    visit '/applications/new'

    fill_in 'Name', with: 'Name'
    fill_in 'Street address', with: '1234 Example St.'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80221'

    click_button 'Begin Application'
    expect(page).to have_field("Pet name")
    expect(page).to have_button("Search Pets")

    fill_in 'Pet name', with: 'Thor'
    click_button 'Search Pets'
    first(:button, "Add pet").click


    fill_in 'Description', with: 'I am a professional dog snuggler'
    click_button 'Submit Application'

    expect(page).to have_content('Thor')
    expect(page).to have_content('I am a professional dog snuggler')
    expect(page).to have_content('Pending')
    expect(page).to have_no_content('Search Pets')

  end

end

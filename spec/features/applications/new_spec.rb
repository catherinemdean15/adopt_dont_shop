require 'rails_helper'

RSpec.describe 'New application page', type: :feature do
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
    click_button 'Begin Application'
    expect(page).to have_content("All fields must be completed")
  end

  it 'has a form to search pets by name' do
    visit '/applications/new'

    fill_in 'Name', with: 'Name'
    fill_in 'Street address', with: '1234 Example St.'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80221'

    click_button 'Begin Application'
    expect(page).to have_field("Pet Name")
    expect(page).to have_button("Search Pets")

  end

end

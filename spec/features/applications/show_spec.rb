require 'rails_helper'

RSpec.describe 'Applications show page', type: :feature do
  before :each do
    @application1 = create(:application)
  end

  it "displays the applicant information" do
    visit "applications/#{@application1.id}"

    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.street_address)
    expect(page).to have_content(@application1.city)
    expect(page).to have_content(@application1.state)
    expect(page).to have_content(@application1.zip)
    expect(page).to have_content(@application1.description)
    expect(page).to have_content(@application1.status)
  end
end

require 'rails_helper'

RSpec.feature "Vistor tries to view a single product", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99)
  end 

  scenario "They see product details when they click details button" do
    # ACT
    visit root_path
    click_link("Details")
    # DEBUG / VERIFY
    expect(page).to have_css('section.products-show')
    save_screenshot
  end

end
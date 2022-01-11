require 'rails_helper'

RSpec.feature "Visitor should be able to add items to cart", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end 

  scenario "They add 1 item to cart they should see 1 cart" do
    # ACT
    visit root_path
    all("button",text:"Add")[0].click
    # DEBUG / VERIFY
    sleep(2)

    expect(page).to have_text("My Cart (1)",count:1)
    save_screenshot
  end

  scenario "They add 3 different items to cart they should see 3 cart" do
    # ACT
    visit root_path
    all("button",text:"Add")[0].click
    sleep(1)
    all("button",text:"Add")[1].click
    sleep(1)
    all("button",text:"Add")[2].click
    # DEBUG / VERIFY
    sleep(2)

    expect(page).to have_text("My Cart (3)",count:1)
    save_screenshot
  end

end
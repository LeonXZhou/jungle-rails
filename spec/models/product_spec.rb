require 'rails_helper'

RSpec.describe Product, type: :model do
  before do 
    @apparel_category = Category.find_or_create_by! name: 'Apparel'
  end

  describe 'Validations' do
    it "Should be valid with correct attributes" do 
      @pants = @apparel_category.products.new({
        name: 'big pants',
        description: Faker::Hipster.paragraph(4),
        image: 'image string',
        quantity: 10,
        price: 10
      })
      expect(@pants).to be_valid()
    end

    it "Should not be valid with name as nil" do 
      @pants = @apparel_category.products.new({
        name: nil,
        description: Faker::Hipster.paragraph(4),
        image: 'image string',
        quantity: 10,
        price: 10
      })
      @pants.validate
      expect(@pants.errors.full_messages).to include ("Name can't be blank")
    end

    it "Should not be valid with price as nil" do 
      @pants = @apparel_category.products.new({
        name: 'big pans',
        description: Faker::Hipster.paragraph(4),
        image: 'image string',
        quantity: 10,
        price: nil
      })
      @pants.validate
      expect(@pants.errors.full_messages).to include ("Price can't be blank")
    end

    it "Should not be valid with quantity as nil" do 
      @pants = @apparel_category.products.new({
        name: 'big pans',
        description: Faker::Hipster.paragraph(4),
        image: 'image string',
        quantity: nil,
        price: 20
      })
      @pants.validate
      expect(@pants.errors.full_messages).to include ("Quantity can't be blank")
    end


    it "Should not be valid with category as nil" do 
      @pants = Product.new({
        name: 'big pans',
        description: Faker::Hipster.paragraph(4),
        image: 'image string',
        quantity: 10,
        price: 20
      })
      @pants.validate
      expect(@pants.errors.full_messages).to include ("Category can't be blank")
    end

  end
end

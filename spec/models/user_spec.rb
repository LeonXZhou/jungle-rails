require 'rails_helper'

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "Should be valid with correct attributes" do 
      @user = User.new({
        first_name: "big bob",
        last_name: "the third",
        email: "bigityBobity@boberoni.com",
        password: "woooop123",
        password_confirmation: "woooop123"
      })
      expect(@user).to be_valid()
    end

    it "Should be invalid with miss matching passwords" do 
      @user = User.new({
        first_name: "big bob",
        last_name: "the third",
        email: "bigityBobity@boberoni.com",
        password: "woooop123",
        password_confirmation: "w00000000000p123"
      })
      expect(@user).to_not be_valid() 
    end

    it "Should be invalid with non-unique emails (case insensitive)" do 
      @user1 = User.new({
        first_name: "big bob",
        last_name: "the third",
        email: "TEST@TEST.com",
        password: "woooop123",
        password_confirmation: "woooop123"
      })
      @user1.save

      @user2 = User.new({
        first_name: "big bob",
        last_name: "the third",
        email: "test@test.COM",
        password: "woooop123",
        password_confirmation: "woooop123"
      })
      expect(@user2).to_not be_valid() 
    end

    it "Should be invalid if first_name is nil" do 
      @user = User.new({
        first_name: nil,
        last_name: "the third",
        email: "bigityBobity@boberoni.com",
        password: "woooop123",
        password_confirmation: "woooop123"
      })
      expect(@user).to_not be_valid() 
    end

    it "Should be invalid if last_name is nil" do 
      @user = User.new({
        first_name: "george",
        last_name: nil,
        email: "bigityBobity@boberoni.com",
        password: "woooop123",
        password_confirmation: "woooop123"
      })
      expect(@user).to_not be_valid() 
    end


    it "Should be invalid if email is nil" do 
      @user = User.new({
        first_name: "elvis",
        last_name: "the third",
        email: nil,
        password: "woooop123",
        password_confirmation: "woooop123"
      })
      expect(@user).to_not be_valid() 
    end

    it "Should be invalid if password is shorter than 8 characters" do 
      @user = User.new({
        first_name: "elvis",
        last_name: "the third",
        email: "shortpassword@gmail.com",
        password: "1234567",
        password_confirmation: "1234567"
      })
      expect(@user).to_not be_valid() 
    end

    it "Should not allow login for incorrect password" do 
      @user = User.new({
        first_name: "elvis",
        last_name: "the third",
        email: "ohnoooooo@gmail.com",
        password: "12345678",
        password_confirmation: "12345678"
      })
      @user.save
      expect(User.authenticate_with_credentials("ohnoooooo@gmail.com","123")).to be(false)
    end

    it "Should not allow login for non-existent email" do
      @user = User.new({
        first_name: "elvis",
        last_name: "the third",
        email: "ohyesssss@gmail.com",
        password: "12345678",
        password_confirmation: "12345678"
      })
      @user.save
      expect(User.authenticate_with_credentials("ooooo@gmail.com","12345678")).to be(false)
    end


    it "Should allow login for correct login credentials" do
      @user = User.new({
        first_name: "elvis",
        last_name: "the third",
        email: "ohnoooooO@gmail.com",
        password: "12345678",
        password_confirmation: "12345678"
      })
      @user.save
      expect(User.authenticate_with_credentials("ohnoooooO@gmail.com","12345678")).to be(true)
    end

    it "Should allow login if email case is wrong" do
      @user = User.new({
        first_name: "elvis",
        last_name: "the third",
        email: "ohnOooOoo@gmail.com",
        password: "12345678",
        password_confirmation: "12345678"
      })
      @user.save
      expect(User.authenticate_with_credentials("oHnOOoOoo@gmail.com","12345678")).to be(true)
    end


    it "Should allow login for accidental space characters in email" do
      @user = User.new({
        first_name: "elvis",
        last_name: "the third",
        email: "ohnOooOoo@gmail.com",
        password: "12345678",
        password_confirmation: "12345678"
      })
      @user.save
      expect(User.authenticate_with_credentials("   oHnOOoOoo@gmail.com ","12345678")).to be(true)
    end

  end
end


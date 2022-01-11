class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: {case_sensitive: false}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, length: {minimum: 8}


  def self.authenticate_with_credentials(email,password)

    if (self.where("LOWER(email) = ?", email.downcase.strip).first)
      if (self.where("LOWER(email) = ?", email.downcase.strip).first.authenticate(password))
        return true
      end
    end
    return false
  end
end

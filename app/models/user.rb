class User < ApplicationRecord
    has_many :books
    has_many :comments
    has_many :commented_books, through: :comments, source: :book

    has_secure_password
    validates :email, :username, presence: true 
    validates :email, uniqueness: true 

    def self.google_omniauth(auth)
      self.find_or_create_by(email: auth[:info][:email]) do |user|
        user.username = auth[:info][:name]
        user.password = SecureRandom.hex
      end
    end

    def self.github_omniauth(auth)
      self.find_or_create_by(email: auth[:info][:email]) do |user|
        user.username = auth[:info][:nickname]
        user.password = SecureRandom.hex
      end
    end
end

class User < ApplicationRecord
    has_many :books
    has_many :comments
    has_many :commented_books, through: :comments, source: :book

    has_secure_password
    validates :email, :username, presence: true 
    validates :email, :username, uniqueness: true 
end

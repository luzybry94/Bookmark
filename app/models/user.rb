class User < ApplicationRecord
    has_many :books
    has_many :comments
    has_many :commented_books, through: :comments, source: :book

    has_secure_password
    validates :email, presence: true 
end

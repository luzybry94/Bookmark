class Book < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments
  validates :title, :author, :genre, :condition, :price, presence: true
end

class Book < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments
  has_many :users, through: :comments
  validates :title, :author, :genre, :condition, :price, presence: true
  # accepts_nested_attributes_for :genres
end

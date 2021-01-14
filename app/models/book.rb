class Book < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments
  validates :title, :author, :condition, :price, presence: true
  accepts_nested_attributes_for :genre
end

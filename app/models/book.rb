class Book < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments
  validates :title, :author, :condition, :price, presence: true
  # accepts_nested_attributes_for :genre

  def genre_attributes=(attributes)
    self.genre = Genre.find_or_create_by(attributes) if !attributes['name'].empty?
    self.genre
  end

  def self.costs_more_than(amount)
    where("price > ?", amount)
  end

  def self.by_genre(genre_id)
    where(genre: genre_id)
  end

  def self.recent_books
    self.order(created_at: :desc)
  end



end

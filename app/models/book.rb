class Book < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments
  has_one_attached :image
  validates :title, :author, :condition, :price, presence: true
  # accepts_nested_attributes_for :genre

  def genre_attributes=(attributes)
    self.genre = Genre.find_or_create_by(attributes) if !attributes['name'].empty?
    self.genre
  end

  def self.order_by_price
    order(price: :desc)
  end

  def self.by_genre(genre_id)
    where(genre: genre_id)
  end

  scope :recent_books, -> { order(created_at: :desc) }





end

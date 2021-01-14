class Book < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments
  validates :title, :author, :condition, :price, presence: true
  # accepts_nested_attributes_for :genre

  def genre_attributes=(genre_attributes)
     genre_attributes.values.each do |genre_attribute|
      if genre_attribute["name"].present?
        genre = Genre.find_or_create_by(genre_attribute)
        self.genre << category
      end
    end
  end

  def self.costs_more_than(amount)
    where("price > ?", amount)
  end


end

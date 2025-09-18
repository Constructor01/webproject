class Image < ApplicationRecord
  belongs_to :theme
  has_one_attached :photo
  has_many :expert_ratings, dependent: :destroy

  validates :title, presence: true

  def average_rating
    expert_ratings.average(:value)&.to_f
  end
end

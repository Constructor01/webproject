class ExpertRating < ApplicationRecord
  belongs_to :user
  belongs_to :image

  validates :value, presence: true, inclusion: { in: 0..100 }

  # Оценки пользователя, попадающие в ±25% от среднего по каждому изображению
  scope :within_25pct_of_image_avg_for_user, ->(user) {
    joins(:image)
      .where(user: user)
      .joins(<<-SQL.squish)
        INNER JOIN (
          SELECT image_id, AVG(value) AS avg_val
          FROM expert_ratings
          GROUP BY image_id
        ) agg ON agg.image_id = expert_ratings.image_id
      SQL
      .where("expert_ratings.value BETWEEN agg.avg_val * 0.75 AND agg.avg_val * 1.25")
  }
end

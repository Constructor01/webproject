class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @total_ratings = @user.expert_ratings.count

    @near_community = ExpertRating.within_25pct_of_image_avg_for_user(@user)
                                  .includes(image: { photo_attachment: :blob })
                                  .order(created_at: :desc)

    @has_near = @near_community.exists?
  end
end

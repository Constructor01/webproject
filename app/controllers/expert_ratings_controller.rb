class ExpertRatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    image = Image.find(params[:image_id])
    value = params[:value].to_i
    comment = params[:comment]
    rating = current_user.expert_ratings.find_or_initialize_by(image: image)
    rating.value = value
    rating.comment = comment
    if rating.save
      redirect_params = Rack::Utils.parse_nested_query(params[:redirect_params].to_s).symbolize_keys
      redirect_to root_path(**redirect_params), notice: t("flash.rating_saved")
    else
      redirect_to root_path, alert: rating.errors.full_messages.to_sentence
    end
  end
end

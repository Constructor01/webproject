module Api
  module V1
    class ExpertRatingsController < ApplicationController
      before_action :authenticate_user!
      protect_from_forgery with: :null_session

      def create
        image = Image.find(params[:image_id])
        rating = current_user.expert_ratings.find_or_initialize_by(image: image)
        rating.value = params.require(:value).to_i
        rating.comment = params[:comment]
        if rating.save
          render json: { ok: true, rating_id: rating.id, value: rating.value, avg: image.average_rating }, status: :created
        else
          render json: { ok: false, errors: rating.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end

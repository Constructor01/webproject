module Api
  module V1
    class ImagesController < ApplicationController
      before_action :authenticate_user!, only: []  # список можно смотреть и без входа
      protect_from_forgery with: :null_session

      def index
        theme = Theme.find(params[:theme_id])
        page = params.fetch(:page, 1).to_i
        per_page = params.fetch(:per, 10).to_i.clamp(1, 50)

        images = theme.images.order(:id).offset((page-1)*per_page).limit(per_page)
        render json: {
          theme_id: theme.id,
          page: page,
          per: per_page,
          total: theme.images.count,
          images: images.map { |im|
            {
              id: im.id,
              title: im.title,
              avg_value: im.average_rating,
              url: (im.photo.attached? ? url_for(im.photo) : nil),
              thumb_url: (im.photo.attached? ? url_for(im.photo.variant(resize_to_limit: [200,150])) : nil)
            }
          }
        }
      end
    end
  end
end

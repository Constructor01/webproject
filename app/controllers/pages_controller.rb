class PagesController < ApplicationController
  def main
    # загрузка для формы
    @themes  = Theme.includes(:images).order(:name)
    # текущая тема и список изображений
    @current_theme = params[:theme_id].present? ? Theme.find_by(id: params[:theme_id]) : Theme.first
    images = @current_theme ? @current_theme.images.order(:id) : Image.none

    # индекс текущей картинки в пределах выбранной темы
    @index = params[:index].to_i
    @index = 0 if @index.negative? || @index >= images.count

    @current_image = images.offset(@index).first
    @images_count  = images.count

    # таблица результатов пользователя по текущей теме (среднее + последние)
    if current_user
      @my_ratings = current_user.expert_ratings.joins(:image)
                                .where(images: { theme_id: @current_theme&.id })
                                .includes(:image).order(created_at: :desc).limit(20)
    else
      @my_ratings = []
    end
  end

  def help; end
  def about; end
end

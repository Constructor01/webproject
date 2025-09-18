class ThemesController < ApplicationController
  def index
    @themes = Theme.includes(:images).order(:name)
  end
end

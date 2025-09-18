class LocaleController < ApplicationController
  def switch
    loc = params[:locale].to_s
    I18n.locale = I18n.available_locales.map(&:to_s).include?(loc) ? loc : I18n.default_locale
    session[:locale] = I18n.locale
    redirect_back fallback_location: root_path
  end
end
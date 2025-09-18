require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ExpertRatings
  class Application < Rails::Application
    config.load_defaults 7.1   # <-- версия может быть другая (7.0, 6.1)
  end
end

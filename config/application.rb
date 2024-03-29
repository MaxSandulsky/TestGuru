require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestGuru
  class Application < Rails::Application
    config.eager_load_paths += %W[#{config.root}/app/specifications]
    config.load_defaults 6.1
    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru
  end
end

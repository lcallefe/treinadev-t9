require_relative "boot"

<<<<<<< HEAD
require "rails/all"
=======
require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"
>>>>>>> 015da33165c05d6f2af0455957a6c0ef3e4a2126

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

<<<<<<< HEAD
module EcommerceApp
=======
module WarehouseApp
>>>>>>> 015da33165c05d6f2af0455957a6c0ef3e4a2126
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
<<<<<<< HEAD
=======

    # Don't generate system test files.
    config.generators.system_tests = nil
>>>>>>> 015da33165c05d6f2af0455957a6c0ef3e4a2126
  end
end

require "active_support"
require "active_support/core_ext"

module DomainViewerTracker
  include ActiveSupport::Configurable
  config_accessor :cookie_domain, :cookie_key_name

  self.configure do |config|
    config.cookie_domain = ""
    config.cookie_key_name = "viewer_id"
  end
end

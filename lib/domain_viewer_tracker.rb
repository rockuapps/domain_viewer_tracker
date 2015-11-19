require "domain_viewer_tracker/version"
require "active_record"
require "action_dispatch"
require "domain_viewer_tracker/configurable"

module DomainViewerTracker

  private

    def set_viewer_id
      unless cookies[key]
        cookies.permanent[key] = { value: SecureRandom.uuid, domain: domain }
      end
    end

    def store_viewer_id(user_id)
      Viewer.find_or_create_by(uuid: cookies[key], user_id: user_id)
    end

    def key
      DomainViewerTracker.cookie_key_name
    end

    def domain
      DomainViewerTracker.cookie_domain
    end
end

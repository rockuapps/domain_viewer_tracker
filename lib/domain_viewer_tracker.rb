require "domain_viewer_tracker/version"
require "action_dispatch"
require "domain_viewer_tracker/configurable"
require "domain_viewer_tracker/viewer"

module DomainViewerTracker

  private
    def viewer_id
      cookies[key]
    end

    def set_viewer_id
      cookies.permanent[key] ||= { value: SecureRandom.uuid, domain: domain }
    end

    def store_viewer_id(user_id)
      set_viewer_id
      Viewer.find_or_create_by(uuid: cookies[key], user_id: user_id)
    end

    def key
      DomainViewerTracker.cookie_key_name
    end

    def domain
      DomainViewerTracker.cookie_domain
    end
end

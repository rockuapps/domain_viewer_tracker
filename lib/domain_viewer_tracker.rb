require "domain_viewer_tracker/version"

module DomainViewerTracker
  mattr_accessor :cookie_domain, :cookie_key_name

  private

    def set_viewer_id
      unless cookies[cookie_key_name]
        cookies[cookie_key_name] = { value: SecureRandom.uuid, domain: cookie_domain }
      end
    end

    def store_viewer_id(user_id)
      Viewer.find_or_create_by(uuid: cookies[:viewer_id], user_id: user_id)
    end
end

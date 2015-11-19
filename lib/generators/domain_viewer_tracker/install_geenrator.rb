module DomainViewerTracker
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def install
      template "create_viewers.rb", "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%d")}_create_viewers.rb"
      template "domain_viewer_tracker.rb", "config/initializes/domain_viewer_tracker"
    end
  end
end

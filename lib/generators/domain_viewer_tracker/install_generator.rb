module DomainViewerTracker
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def install
      template "create_viewers.rb", "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%d")}_create_viewers.rb"
      template "domain_viewer_tracker.rb", "config/initializers/domain_viewer_tracker.rb"
      template "viewer.rb", "app/models/viewer.rb"
    end
  end
end

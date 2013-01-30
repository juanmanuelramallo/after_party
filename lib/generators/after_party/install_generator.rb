require 'rails/generators'

module AfterParty
  module Generators

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_initializer_file
        create_file "config/initializers/after_party.rb", "# Welcome to the party!"
      end

      def copy_data_version
        template "data_version.rb", File.join(Rails.root, "lib/data_version.rb")
      end

      def copy_data_version_file
        template "data_version_file.rb", File.join(Rails.root, "lib/data_version_file.rb")
      end

      def copy_migration
        unless migration_exists?
          template "migration.rb", "db/migrate/#{timestamp}_create_data_versions.rb"
        end
      end

      def copy_rake_task
        template "deploy_task_runner.rake", File.join(Rails.root, "lib/tasks/deploy_task_runner.rake")
      end

      private
      def timestamp
        @timestamp ||= Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def migration_exists?
        Dir.glob("#{File.join("./db/migrate")}/[0-9]*_create_data_versions.rb").first
      end
    end
  end
end
module Fastlane
  module Actions
    class UpdateChangelogAction < Action
      require 'yaml'
      def self.run(params)

        pre_change_data = params[:info]
        raise "The pre_change_data should not be nil".red unless (pre_change_data)

        # version = pre_change_data[:version]
        # raise "The version should not be nil".red unless (version)

        log_title = pre_change_data[:log_title]
        raise "The log_title should not be nil".red unless (log_title)

        log_text = pre_change_data[:log_text]
        raise "The log_text should not be nil".red unless (log_text)

        change_log_file = File.read(params[:changelogfile])

        File.open(params[:changelogfile], 'w') { |file| file.write(change_log_file.sub("-----", "-----\n\n#{log_title}#{log_text}-----")) }

        # return {:change_log => log_text}
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Update the changelog file with the content of pre-change.yml"
      end

      def self.details
        "Generally speaking, the log is return value of pre-change log"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :info,
            env_name: "CHANGELOG_LOG",
            description: "Changelog extracted by pre change file",
            is_string: false
            ),
          FastlaneCore::ConfigItem.new(
            key: :changelogfile,
            env_name: "CHANGELOG_FILE",
            description: "The changelog file, if not set, CHANGELOG.md will be used",
            default_value: "CHANGELOG.md")
        ]
      end

      def self.authors
        ["Cove"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end

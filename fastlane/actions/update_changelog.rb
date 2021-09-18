module Fastlane
  module Actions
    class UpdateChangelogAction < Action
      require 'yaml'
      def self.run(params)

        pre_change_data = params[:info]
        raise "The pre_change_data should not be nil".red unless (pre_change_data)

        version = pre_change_data[:version]
        raise "The version should not be nil".red unless (version)

        add = pre_change_data[:add]
        fix = pre_change_data[:fix]
        remove = pre_change_data[:remove]

        title_url = "https://github.com/cove1205/Plume/releases/tag/#{version}"
        title_time = Time.now.strftime("%Y-%m-%d")

        title = "## [#{version}](#{title_url}) (#{title_time})\n\n"
        log_text = title
        
        add = add.map { |i| "* #{i}" }.join("\n") unless add.nil?
        log_text = log_text + "### Add\n\n#{add}\n\n" unless add.nil? or add.empty?

        fix = fix.map { |i| "* #{i}" }.join("\n") unless fix.nil?
        log_text = log_text + "### Fix\n\n#{fix}\n\n" unless fix.nil? or fix.empty?
          
        remove = remove.map { |i| "* #{i}" }.join("\n") unless remove.nil?
        log_text = log_text + "### Remove\n\n#{remove}\n\n" unless remove.nil? or remove.empty?

        change_log_file = File.read(params[:changelogfile])

        File.open(params[:changelogfile], 'w') { |file| file.write(change_log_file.sub("-----", "-----\n\n#{log_text}-----")) }

        return {:change_log => log_text}
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

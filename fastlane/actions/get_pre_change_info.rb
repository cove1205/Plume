module Fastlane
  module Actions
    class GetPreChangeInfoAction < Action
      require 'yaml'
      def self.run(params)

        pre_change_file = File.read(params[:prechangeflie])
        raise "The pre-change.yml is not exist".red unless (pre_change_file)

        pre_change_data = YAML.load(pre_change_file)
        raise "The data of pre-change.yml should not be nil".red unless (pre_change_data)

        version = pre_change_data["version"]
        raise "The version should not be nil in the input file".red unless (version)

        add = pre_change_data["add"]
        fix = pre_change_data["fix"]
        remove = pre_change_data["remove"]

        return {:version => version, :add => add, :fix => fix, :remove => remove}
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Extract changelog information from a pre-change file."
      end

      def self.details
        "This action will check input file. If everything goes well, the changelog info will be returned."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :prechangeflie,
            env_name: "PRECHANGE_FILE",
            description: "The pre-change flie, if not set, pre-change.yml will be used",
            default_value: "pre-change.yml")
        ]
      end

      def self.return_value
        "An object contains changelog infomation."
      end

      def self.is_supported?(platform)
        true
      end

      def self.authors
        ["Cove"]
      end
    end
  end
end

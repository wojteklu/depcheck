module Depcheck
  module Finder

    def self.find_derived_data_path(project, workspace, scheme)
      arg = if project
              "-project \"#{project}\""
            else
              "-workspace \"#{workspace}\" -scheme \"#{scheme}\""
            end

      build_settings = `xcodebuild #{arg} -showBuildSettings build CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO 2>&1`

      if build_settings
        derived_data_path = build_settings.match(/ OBJROOT = (.+)/)
        derived_data_path = derived_data_path[1] if derived_data_path
      end

      derived_data_path
    end

    def self.find_swiftdeps(project, workspace, scheme)
      derived_data_path = find_derived_data_path(project, workspace, scheme)
      swiftdeps = Dir.glob("#{derived_data_path}/**/*.swiftdeps") if derived_data_path

      if swiftdeps.nil? || swiftdeps.empty?
        raise StandardError, 'No derived data found. Please make sure the project was built.'
      end

      swiftdeps
    end

  end
end

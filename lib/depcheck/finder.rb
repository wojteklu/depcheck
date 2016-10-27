module Depcheck
  module Finder

    def self.find_derived_data_path(project, workspace, scheme)
      arg = if project
              "-project \"#{project}\""
            else
              "-workspace \"#{workspace}\""
            end

      arg+= " -scheme \"#{scheme}\"" if scheme

      build_settings = `xcodebuild #{arg} -showBuildSettings build CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO`
      raise StandardError until $?.success?

      derived_data_path = build_settings.match(/ OBJROOT = (.+)/)[1]
      project_name = build_settings.match(/ PROJECT_NAME = (.+)/)[1]
      target_name = build_settings.match(/ TARGET_NAME = (.+)/)[1]

      "#{derived_data_path}/#{project_name}.build/**/#{target_name}*.build"
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

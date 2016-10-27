class UsageCommand < Clamp::Command
  option ['--project'], 'PROJECT', 'Path to the xcodeproj'
  option ['--scheme'], 'SCHEME', 'The scheme that the project was built in'
  option ['--workspace'], 'WORKSPACE', 'Path to the workspace'

  def execute
    results = Depcheck.run(project, workspace, scheme)
    Depcheck::SimpleOutput.post_usage(results)
  end

end

class AnalyzeCommand < Clamp::Command
  option ['--project'], 'PROJECT', 'Path to the xcodeproj'
  option ['--scheme'], 'SCHEME', 'The scheme that the project was built in'
  option ['--workspace'], 'WORKSPACE', 'Path to the workspace'

  def execute

    unless project || (workspace && scheme)
      raise StandardError, 'Must provide project path or workspace path with scheme.'
    end

    swiftdeps = Depcheck::Finder.find_swiftdeps(project, workspace, scheme)
    results = Depcheck::Analyzer.generate_dependencies(swiftdeps)
    Depcheck::SimpleOutput.post(results)
  end

end

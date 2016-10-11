class GraphCommand < Clamp::Command
  option ['--project'], 'PROJECT', 'Path to the xcodeproj'
  option ['--scheme'], 'SCHEME', 'The scheme that the project was built in'
  option ['--workspace'], 'WORKSPACE', 'Path to the workspace'
  option ["--include"], "INCLUDE", "Regexp of classes that will be shown on graph"

  def execute

    unless project || (workspace && scheme)
      raise StandardError, 'Must provide project path or workspace path with scheme.'
    end

    swiftdeps = Depcheck::Finder.find_swiftdeps(project, workspace, scheme)
    analyzer = Depcheck::Analyzer.new
    results = analyzer.generate_dependencies(swiftdeps)
    output = Depcheck::GraphOutput.new
    output.post(results, include)
  end

end

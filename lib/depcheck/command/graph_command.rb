class GraphCommand < Clamp::Command
  option ['--project'], 'PROJECT', 'Path to the xcodeproj'
  option ['--scheme'], 'SCHEME', 'The scheme that the project was built in'
  option ['--workspace'], 'WORKSPACE', 'Path to the workspace'
  option ["--include"], "INCLUDE", "Regexp of classes that will be shown on graph"
  option ["--dot", "-d"], :flag, "Export dot file"

  def execute
    results = Depcheck.run(project, workspace, scheme)
    output = Depcheck::GraphOutput.new
    output.post(results, include, dot?)
  end

end

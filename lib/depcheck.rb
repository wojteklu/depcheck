require 'depcheck/finder'
require 'depcheck/analyzer'
require 'depcheck/dependency_info'
require 'depcheck/output/simple_output'
require 'depcheck/output/graph_output'
require 'depcheck/version'

module Depcheck
  Encoding.default_external = 'utf-8'

  def self.run(project, workspace, scheme)

    unless project || (workspace && scheme)
      raise StandardError, 'Must provide project path or workspace path with scheme.'
    end

    swiftdeps = Depcheck::Finder.find_swiftdeps(project, workspace, scheme)
    analyzer = Depcheck::Analyzer.new
    results = analyzer.generate_dependencies(swiftdeps)
  end

end

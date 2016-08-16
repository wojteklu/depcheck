module Depcheck
  class DependencyInfo
    attr_accessor :name, :nominal, :dependencies, :usage

    def initialize(name, nominal, dependencies)
      self.name = name
      self.nominal = nominal
      self.dependencies = dependencies
      self.usage = 0
    end

  end
end

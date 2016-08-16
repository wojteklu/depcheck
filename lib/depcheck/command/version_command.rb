class VersionCommand < Clamp::Command

  def execute
    puts "depcheck #{Depcheck::VERSION}"
  end
end

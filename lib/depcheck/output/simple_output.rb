module Depcheck
  module SimpleOutput

    def self.post(objs)
      objs = objs.sort_by { |obj| obj.dependencies.size }.reverse

      objs.each_with_index do |obj, index|
        puts "#{index + 1}. #{obj.name} - #{obj.dependencies.size} \n"
      end
    end

    def self.post_usage(objs)
      objs = objs.sort_by(&:usage).reverse

      objs.each_with_index do |obj, index|
        puts "#{index + 1}. #{obj.name} - #{obj.usage} \n"
      end
    end

  end
end

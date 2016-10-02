require File.expand_path('../spec_helper', __FILE__)

module Depcheck

  describe SimpleOutput do
    before :all do
      @dependencies = 3.times.map do |i|
        dep = DependencyInfo.new("A#{i}", "B#{i}", i.times.map(&:to_s))
        dep.usage = 3-i
        dep
      end
    end

    describe :post do

      it 'outputs results sorted by dependencies count' do
        expected = "1. A2 - 2\n2. A1 - 1\n3. A0 - 0\n"
        expect { Depcheck::SimpleOutput.post(@dependencies, false)}.to output(expected).to_stdout
      end

      it 'outputs results with dependencies list' do
        expected = "1. A2 - 2 - [0, 1]\n2. A1 - 1 - [0]\n3. A0 - 0 - []\n"
        expect { Depcheck::SimpleOutput.post(@dependencies, true)}.to output(expected).to_stdout
      end
    end

    describe :post_usage do

      it 'outputs results sorted by usage count' do
        expected = "1. A0 - 3\n2. A1 - 2\n3. A2 - 1\n"
        expect { Depcheck::SimpleOutput.post_usage(@dependencies)}.to output(expected).to_stdout
      end
    end

  end
end

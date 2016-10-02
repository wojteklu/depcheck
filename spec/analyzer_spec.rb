require File.expand_path('../spec_helper', __FILE__)

module Depcheck

  describe Analyzer do
    before :all do
      Analyzer.send(:public, *Analyzer.private_instance_methods)
      @analyzer = Analyzer.new
    end

    describe :generate_dependencies do

      it 'generates dependencies for files' do
        files = ["./spec/fixtures/Model1.swiftdeps", "./spec/fixtures/Model4.swiftdeps"]
        results = @analyzer.generate_dependencies(files)

        expect(results[0].name).to eq "Model1"
        expect(results[0].usage).to eq 1
        expect(results[0].dependencies.count).to eq 2

        expect(results[1].name).to eq "Model4"
        expect(results[1].usage).to eq 0
        expect(results[1].dependencies.count).to eq 1
      end

    end

    describe :valid_dep? do
      before do
        allow_any_instance_of(Analyzer).to receive(:keyword?).and_return(false)
        allow_any_instance_of(Analyzer).to receive(:framework?).and_return(false)
      end

      it 'validates nil values' do
        expect(@analyzer.valid_dep?(nil)).to eq false
      end

      it 'validates keywords values' do
        allow_any_instance_of(Analyzer).to receive(:keyword?).and_return(true)
        expect(@analyzer.valid_dep?("test")).to eq false
      end

      it 'validates non-alphanumeric values' do
        expect(@analyzer.valid_dep?("*")).to eq false
      end

      it 'validates framework prefixes' do
        allow_any_instance_of(Analyzer).to receive(:framework?).and_return(true)
        expect(@analyzer.valid_dep?("test")).to eq false
      end
    end

  end
end

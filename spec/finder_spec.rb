require File.expand_path('../spec_helper', __FILE__)

module Depcheck

  describe Finder do

    describe :find_derived_data_path do
      before do
        allow(Finder).to receive(:`).and_return(" OBJROOT = D/D\n PROJECT_NAME = P\n TARGET_NAME = T")
      end

      it 'finds derived data path' do
        expected = "D/D/P.build/**/T*.build"
        expect(Finder.find_derived_data_path("Test", nil, nil)).to eq expected
      end
    end

    describe :find_swiftdeps do
      before do
        allow(Finder).to receive(:find_derived_data_path).and_return('')
      end

      it 'finds swiftdeps files' do
        expected = 2.times.map(&:to_s)
        allow(Dir).to receive(:glob).and_return(expected)
        expect(Finder.find_swiftdeps("Test", nil, nil)).to eq expected
      end

      it 'raises error if files not found' do
        allow(Dir).to receive(:glob).and_return([])
        expect{Finder.find_swiftdeps("Test", nil, nil)}.to raise_error(StandardError)
      end

    end
  end
end

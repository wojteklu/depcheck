require 'yaml'

module Depcheck
  class Analyzer

    def generate_dependencies(swiftdeps)
      results = []
      usage = {}

      swiftdeps.each do |my_text_file|
        begin
          dependencies = YAML.load_file(my_text_file)
        rescue
          next
        end

        provides = dependencies['provides-top-level']
        nominals = dependencies['provides-nominal']
        depends = dependencies['depends-top-level'] || []
        depends_member = dependencies['depends-member'] || []

        if provides.nil? || nominals.nil? || provides.count != nominals.count
          next
        end

        provides.zip(nominals).each do |name, nominal|
          dependencies = []

          depends_member.each do |d|
            if d[0] == nominal && depends.include?(d[1]) && valid_dep?(d[1])
              dependencies << d[1]
              usage[d[1]] = usage[d[1]].to_i + 1
            end
          end

          results << DependencyInfo.new(name, nominal, dependencies)
        end
      end

      results.each do |r|
        value = usage[r.name]
        r.usage = value if value
      end

      results
    end

    def valid_dep?(dep)
      !dep.nil? && !/^(<\s)?\w/.match(dep).nil? && !keyword?(dep) && !framework?(dep)
    end
    private :valid_dep?

    def framework?(dep)
      /^(CA|CF|CG|CI|CL|kCA|NS|UI)/.match(dep) != nil
    end
    private :framework?

    def keyword?(dep)
      /^(Any|AnyBidirectionalCollection|AnyBidirectionalIndex|AnyClass|AnyForwardCollection|AnyForwardIndex|AnyObject|AnyRandomAccessCollection|AnyRandomAccessIndex|AnySequence|Array|ArraySlice|AutoreleasingUnsafeMutablePointer|BOOL|Bool|BooleanLiteralType|CBool|CChar|CChar16|CChar32|CDouble|CFloat|CInt|CLong|CLongLong|COpaquePointer|CShort|CSignedChar|CUnsignedChar|CUnsignedInt|CUnsignedLong|CUnsignedLongLong|CUnsignedShort|CVaListPointer|CWideChar|Character|ClosedInterval|ClusterType|CollectionOfOne|ContiguousArray|DISPATCH_|Dictionary|DictionaryGenerator|DictionaryIndex|DictionaryLiteral|Double|EmptyGenerator|EnumerateGenerator|EnumerateSequence|ExtendedGraphemeClusterType|FlattenBidirectionalCollection|FlattenBidirectionalCollectionIndex|FlattenCollectionIndex|FlattenSequence|Float|Float32|Float64|FloatLiteralType|GeneratorSequence|HalfOpenInterval|IndexingGenerator|Int|Int16|Int32|Int64|Int8|IntMax|IntegerLiteralType|JoinGenerator|JoinSequence|LazyCollection|LazyFilterCollection|LazyFilterGenerator|LazyFilterIndex|LazyFilterSequence|LazyMapCollection|LazyMapGenerator|LazyMapSequence|LazySequence|LiteralType|ManagedBufferPointer|Mirror|MutableSlice|ObjectIdentifier|Optional|PermutationGenerator|Range|RangeGenerator|RawByte|Repeat|ReverseCollection|ReverseIndex|ReverseRandomAccessCollection|ReverseRandomAccessIndex|ScalarType|Set|SetGenerator|SetIndex|Slice|StaticString|StrideThrough|StrideThroughGenerator|StrideTo|StrideToGenerator|String|String.CharacterView|String.CharacterView.Index|String.UTF16View|String.UTF16View.Index|String.UTF8View|String.UTF8View.Index|String.UnicodeScalarView|String.UnicodeScalarView.Generator|String.UnicodeScalarView.Index|StringLiteralType|UInt|UInt16|UInt32|UInt64|UInt8|UIntMax|UTF16|UTF32|UTF8|UnicodeScalar|UnicodeScalarType|Unmanaged|UnsafeBufferPointer|UnsafeBufferPointerGenerator|UnsafeMutableBufferPointer|UnsafeMutablePointer|UnsafePointer|Void|Zip2Generator|Zip2Sequence|abs|alignof|alignofValue|anyGenerator|anyGenerator|assert|assertionFailure|debugPrint|debugPrint|dispatch_|dump|dump|fatalError|getVaList|isUniquelyReferenced|isUniquelyReferencedNonObjC|isUniquelyReferencedNonObjC|max|max|min|min|numericCast|numericCast|numericCast|numericCast|precondition|preconditionFailure|print|print|readLine|sizeof|sizeofValue|strideof|strideofValue|swap|transcode|unsafeAddressOf|unsafeBitCast|unsafeDowncast|unsafeUnwrap|withExtendedLifetime|withExtendedLifetime|withUnsafeMutablePointer|withUnsafeMutablePointers|withUnsafeMutablePointers|withUnsafePointer|withUnsafePointers|withUnsafePointers|withVaList|withVaList|zip)$/.match(dep) != nil
    end
    private :keyword?

  end
end

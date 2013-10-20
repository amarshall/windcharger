require 'spec_helper'
require 'windcharger/hash_transformer'

describe Windcharger::HashTransformer do
  describe "#transform" do
    it "returns a hash with attribute names and return values from those methods" do
      transformer_class = Class.new do
        extend Windcharger::Attributes
        include Windcharger::HashTransformer

        attribute
        def foo; 42; end
        attribute
        def bar; 'colorless green ideas'; end
        def baz; end
      end
      transformer = transformer_class.new

      expect(transformer.transform).to eq({
        foo: 42,
        bar: 'colorless green ideas',
      })
    end
  end
end

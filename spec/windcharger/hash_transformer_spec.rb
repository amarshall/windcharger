require 'spec_helper'
require 'windcharger/hash_transformer'

describe Windcharger::HashTransformer do
  describe "#transform" do
    it "returns a hash with attribute names as keys and their method results as values" do
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

    it "does not call private methods" do
      transformer_class = Class.new do
        extend Windcharger::Attributes
        include Windcharger::HashTransformer

        private
        attribute
        def foo; 42; end
      end
      transformer = transformer_class.new

      expect { transformer.transform }.to raise_error NoMethodError, /private/
    end
  end
end

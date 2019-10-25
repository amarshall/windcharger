require 'spec_helper'
require 'windcharger/attributes'

describe Windcharger::Attributes do
  it "attributes is an empty array by default" do
    transformer_class = Class.new { extend Windcharger::Attributes }
    expect(transformer_class.attributes).to eq []
  end

  it "attribute is private" do
    transformer_class = Class.new { extend Windcharger::Attributes }
    expect { transformer_class.attribute }.to raise_error NoMethodError, /private/
  end

  it "adds attributes to the list, not affecting the next method added, when attribute is called with params" do
    transformer_class = Class.new do
      extend Windcharger::Attributes
      attribute :foo, :bar
      def baz; end
    end
    expect(transformer_class.attributes).to eq [:foo, :bar]
  end

  it "does not add a method to attributes when its def is not preceded by a call to attribute" do
    transformer_class = Class.new do
      extend Windcharger::Attributes

      def foo; end
    end
    expect(transformer_class.attributes).to eq []
  end

  it "adds a method to attributes when its def is preceded by a call to attribute" do
    transformer_class = Class.new do
      extend Windcharger::Attributes

      attribute
      def foo; end
    end
    expect(transformer_class.attributes).to eq [:foo]
  end

  it "appropriately does and does not add multiple methods" do
    transformer_class = Class.new do
      extend Windcharger::Attributes

      attribute
      def foo; end

      def bar; end
      def baz; end

      attribute
      def qux; end

      attribute
      def foobar; end

      def barbaz; end
    end

    expect(transformer_class.attributes).to eq [:foo, :qux, :foobar]
  end

  it "does not permit mutating attributes indirectly" do
    transformer_class = Class.new do
      extend Windcharger::Attributes

      attribute
      def foo; end
    end
    expect { transformer_class.attributes << :bar }.to raise_error FrozenError
    expect(transformer_class.attributes).to eq [:foo]
  end
end

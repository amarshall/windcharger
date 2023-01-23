# frozen_string_literal: true

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

  it "does not break other method_added hooks" do
    calls_before = []
    calls_after = []
    other_hooker_before = Module.new do
      define_method :method_added do |name|
        super name
        calls_before << name
      end
    end
    other_hooker_after = Module.new do
      define_method :method_added do |name|
        super name
        calls_after << name
      end
    end

    Class.new do
      extend other_hooker_before
      extend Windcharger::Attributes
      extend other_hooker_after

      attribute
      def foo; end

      def bar; end
    end

    expect(calls_before).to eq %i[foo bar]
    expect(calls_after).to eq %i[foo bar]
  end

  it 'inherits attributes from its superclass' do
    parent_class = Class.new do
      extend Windcharger::Attributes

      attribute
      def foo; end
    end

    transformer_class = Class.new(parent_class) do
      attribute
      def bar; end
    end

    expect(transformer_class.attributes).to match_array [:foo, :bar]
  end
end

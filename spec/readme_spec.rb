require 'spec_helper'
require 'windcharger'

describe "readme" do
  describe "example 1" do
    before do
      class MyTransformer
        extend Windcharger::Attributes

        attribute
        def foo; end

        attribute
        def bar; end

        def not_an_attribute; end
      end
    end

    after do
      Object.send :remove_const, :MyTransformer
    end

    it "works" do
      expect(MyTransformer.attributes).to eq [:foo, :bar]
    end
  end

  describe "example 1" do
    before do
      class MyTransformer
        extend Windcharger::Attributes
        include Windcharger::HashTransformer

        attribute
        def foo
          :the_foo
        end

        attribute
        def bar
          :walked_into_a_bar
        end

        def not_an_attribute
          42
        end
      end
    end

    after do
      Object.send :remove_const, :MyTransformer
    end

    it "works" do
      my_transformer = MyTransformer.new
      expect(my_transformer.transform).to eq({ :foo => :the_foo, :bar => :walked_into_a_bar })
    end
  end
end

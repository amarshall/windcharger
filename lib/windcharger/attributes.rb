# frozen_string_literal: true

module Windcharger
  module Attributes
    def attributes
      @__windcharger_attributes ||= []
      super_attrs = superclass.respond_to?(:attributes) ? superclass.attributes : []
      [*super_attrs, *@__windcharger_attributes].freeze
    end

    private

    def __windcharger_add_attribute name
      (@__windcharger_attributes ||= []) << name.to_sym
    end

    def attribute *attributes
      if attributes.any?
        attributes.each { |attribute| __windcharger_add_attribute attribute }
      else
        @__windcharger_next_is_attribute = true
      end
    end

    def method_added name
      super
      return unless defined?(@__windcharger_next_is_attribute) && @__windcharger_next_is_attribute
      __windcharger_add_attribute name
      @__windcharger_next_is_attribute = false
    end
  end
end

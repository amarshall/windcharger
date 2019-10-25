module Windcharger
  module Attributes
    def attributes
      (@__attributes || []).dup.freeze
    end

    private

    def __windcharger_add_attribute name
      (@__attributes ||= []) << name.to_sym
    end

    def attribute *attributes
      if attributes.any?
        attributes.each { |attribute| __windcharger_add_attribute attribute }
      else
        @__windcharger_next_is_attribute = true
      end
    end

    def method_added name
      return unless @__windcharger_next_is_attribute
      __windcharger_add_attribute name
      @__windcharger_next_is_attribute = false
    end
  end
end

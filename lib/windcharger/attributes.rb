module Windcharger
  module Attributes
    def attributes
      @__attributes || []
    end

    private

    def attribute
      @__windcharger_next_is_attribute = true
    end

    def method_added name
      return unless @__windcharger_next_is_attribute
      (@__attributes ||= []) << name
      @__windcharger_next_is_attribute = false
    end
  end
end

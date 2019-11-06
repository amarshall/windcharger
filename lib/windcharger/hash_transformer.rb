# frozen_string_literal: true

module Windcharger
  module HashTransformer
    def transform
      self.class.attributes.each_with_object({}) do |attribute, hash|
        hash[attribute] = public_send(attribute)
      end.freeze
    end

    def to_h(*args, &block)
      transform(*args, &block)
    end
  end
end

require "active_support/core_ext/object/deep_dup"

module ActiveRemote
  module Enum
    extend ActiveSupport::Concern

    def enum(definitions)
      klass = self
      defined_enums = ActiveSupport::HashWithIndifferentAccess.new
      enum_prefix = definitions.delete(:_prefix)
      enum_suffix = definitions.delete(:_suffix)
      enum_scopes = definitions.delete(:_scopes)

      definitions.each do |attribute_name, values|
        attribute attribute_name
        enum_values = ActiveSupport::HashWithIndifferentAccess.new
        defined_enums[attribute_name.to_s] = enum_values

        pairs = values.respond_to?(:each_pair) ? values.each_pair : values.each_with_index

        pairs.each do |label, value|
          if enum_prefix == true
            prefix = "#{attribute_name}_"
          elsif enum_prefix
            prefix = "#{enum_prefix}_"
          end
          if enum_suffix == true
            suffix = "_#{attribute_name}"
          elsif enum_suffix
            suffix = "_#{enum_suffix}"
          end

          value_method_name = "#{prefix}#{label}#{suffix}"
          enum_values[label] = value
          label = label.to_s

          define_method("#{attribute_name}") do
            self[attribute_name].to_s
          end

          define_method("#{value_method_name}?") do
            self[attribute_name].to_s == label
          end
          #define_method("#{value}!") { update!(attribute_name => value.to_s) }

          if enum_scopes != false
            klass.define_singleton_method(value_method_name) do
              [klass.find(attribute_name => value)].flatten
            end

            # klass.define_singleton_method("not_#{value_method_name}") do
            # TODO: does find support `not`?
            #   klass.find(attribute_name => value)
            # end
          end
        end
      end
    end
  end
end

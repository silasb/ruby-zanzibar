require_relative "./internal_evaler"
require_relative "./tuple_stores/nop"

module Zanzibar
  module Behavior
    def self.included(base)
      # Handle ActiveSupport::Concern differently
      if base.respond_to?(:class_methods)
        base.class_methods do
          include ClassMethods
        end
      else
        base.extend ClassMethods
      end
    end

    module ClassMethods
      def tuples_store(it)
        @tuple_store = it
      end

      def define(r, as:)
        tuple_store = @tuple_store || TupleStores::Nop.new

        define_method r do |args|
          p [:policy_proc_check, r, args]
          InternalEvaler.new(r, as, self, tuple_store, args).eval
        end
      end
    end
  end
end
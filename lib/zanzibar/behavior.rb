require_relative "./internal_evaler"
# TODO: make TupleFinders::Sqlite configurable via Policy
require_relative "./tuple_finders/sqlite.rb"

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
      def define(r, as:)
        define_method r do |args|
          p [:policy_proc_check, r, args]
          # TODO: make TupleFinders::Sqlite configurable via Policy
          InternalEvaler.new(r, as, self, TupleFinders::Sqlite, args).eval
        end
      end
    end
  end
end
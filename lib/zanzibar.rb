# frozen_string_literal: true

require_relative "zanzibar/version"
require_relative "zanzibar/behavior"

module Zanzibar
  class Error < StandardError; end

  def self.check?(p_subject_namespace, p_subject, p_relation, p_object_namespace, p_object)
    p [:query, [p_subject_namespace, p_subject, p_relation, p_object_namespace, p_object]]

    klass =  Object.const_get("#{p_object_namespace.capitalize}Policy") rescue nil
    p [:find_policy_class, klass]

    meth = klass.instance_methods(false).find { _1 == p_relation.to_sym }
    return false if meth.nil?
    p [:find_define, meth]

    klass.new.send(meth, [p_subject_namespace, p_subject, p_relation, p_object_namespace, p_object])
  end
end

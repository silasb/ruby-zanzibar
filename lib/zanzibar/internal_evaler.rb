module Zanzibar
  class InternalEvaler
    def initialize(r, as, policy, tuple_finder, args)
      @r = r
      @as = as
      @policy = policy
      @tuple_finder = tuple_finder
      @args = args
    end

    def method_missing(method, *args, &block)
      @policy.send(method, @args)
    end

    def eval
      p 'eval'
      as = @as
      instance_eval(&as)
    end

    def _self
      subject, subject_id, relation, object, object_id = @args
      new_args = [subject, subject_id, @r.to_s, object, object_id]
      p [:tuple_store_find, new_args]
      res = @tuple_finder.find(*new_args)
      p [:tuple_store_find, new_args, res]
      res
    end
  end
end
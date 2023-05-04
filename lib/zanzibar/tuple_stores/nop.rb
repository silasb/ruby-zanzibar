module Zanzibar
  module TupleStores
    class Nop
      def find(p_subject_namespace, p_subject, p_relation, p_object_namespace, p_object)
        p [:query, [p_subject_namespace, p_subject, p_relation, p_object_namespace, p_object]]
        p [p_object_namespace, p_object, p_relation]

       false
      end
    end
  end
end
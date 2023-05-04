module Zanzibar
  module TupleStores
    class SQLite3
      CHECK_QUERY = <<-SQL
      SELECT
          object,
          object_namespace,
          relation,
          subject,
          subject_namespace,
          subject_relation
        FROM
          tuples
        WHERE
          object_namespace = ?
          AND (object = ? OR object = '*')
          AND relation = ?
        ORDER BY
          subject_relation NULLS FIRST
      SQL

      def initialize(file, table)
        require 'sqlite3'

        db = ::SQLite3::Database.new(file)
        db.results_as_hash = true

        @db = db

        @table = table
      end

      def find(p_subject_namespace, p_subject, p_relation, p_object_namespace, p_object)
        p [:query, [p_subject_namespace, p_subject, p_relation, p_object_namespace, p_object]]
        p [p_object_namespace, p_object, p_relation]

        @db.execute(CHECK_QUERY, [p_object_namespace, p_object, p_relation]) do |var_r|
          p var_r
          if var_r['subject'] == p_subject && var_r['subject_namespace'] == p_subject_namespace
            return true
          end
          # p [p_subject_namespace, p_subject, var_r['subject_relation'], var_r['subject_namespace'], var_r['subject']]

          if var_r['subject_namespace'] != nil && var_r['subject_relation'] != nil
            new_args = [p_subject_namespace, p_subject, var_r['subject_relation'], var_r['subject_namespace'], var_r['subject']]
            p [:recursive_lookup, new_args]
            # p [p_subject_namespace, p_subject, var_r['subject_relation'], var_r['subject_namespace'], var_r['subject']]
            var_b = Zanzibar.check?(*new_args)
            if var_b
              return true
            end
          end
        end

        return false
      end
    end
  end
end
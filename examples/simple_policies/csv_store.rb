require 'csv'

class CSVStore
  def initialize(csv_file)
    @csv = CSV.open(csv_file, col_sep: "\t", quote_char: nil, headers: :true, header_converters: :symbol)
    @data = @csv.each.to_a
  end

  def find(p_subject_namespace, p_subject, p_relation, p_object_namespace, p_object)
    p [:query, [p_subject_namespace, p_subject, p_relation, p_object_namespace, p_object]]
    p [p_object_namespace, p_object, p_relation]

    @data.select { _1[:object_namespace] == p_object_namespace && _1[:object] == p_object && _1[:relation] == p_relation }.each do |var_r|
      if var_r[:subject] == p_subject && var_r[:subject_namespace] == p_subject_namespace
        return true
      end

      if var_r[:subject_namespace] != nil && var_r[:subject_relation] != nil
        new_args = [p_subject_namespace, p_subject, var_r[:subject_relation], var_r[:subject_namespace], var_r[:subject]]
        p [:recursive_lookup, new_args]
        # p [p_subject_namespace, p_subject, var_r['subject_relation'], var_r['subject_namespace'], var_r['subject']]
        var_b = Zanzibar.check?(*new_args)
        if var_b
          return true
        end
      end
    end

    false
  end
end

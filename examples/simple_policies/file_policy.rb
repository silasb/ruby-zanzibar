class FilePolicy
  include Zanzibar::Behavior

  tuples_store CSVStore.new('examples/simple_policies/tuples.tsv')

  define :owner, as: proc { _self }
  define :viewer, as: proc { _self || owner }
  define :writer, as: proc { _self || owner }
end
class OrgPolicy
  include Zanzibar::Behavior

  tuples_store CSVStore.new('examples/simple_policies/tuples.tsv')

  define :owner, as: proc { _self }
  define :member, as: proc { _self || owner }
end
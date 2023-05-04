require 'zanzibar/tuple_stores/sqlite3'

class OrgPolicy
  include Zanzibar::Behavior

  tuples_store Zanzibar::TupleStores::SQLite3.new("test.db", "tuples")

  define :owner, as: proc { _self }
  define :member, as: proc { _self || owner }
end

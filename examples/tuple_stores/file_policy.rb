require 'zanzibar/tuple_stores/sqlite3'

class FilePolicy
  include Zanzibar::Behavior

  tuples_store Zanzibar::TupleStores::SQLite3.new("test.db", "tuples")

  define :owner, as: proc { _self }
  define :viewer, as: proc { _self || owner }
  define :writer, as: proc { _self || owner }
end

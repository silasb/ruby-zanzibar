
require 'sqlite3'
$db = SQLite3::Database.new "test.db"
$db.results_as_hash = true
$db.execute "DROP TABLE IF EXISTS tuples;"

rows = $db.execute <<-SQL
  CREATE TABLE tuples (
    object text NOT NULL,
    object_namespace text NOT NULL,
    relation text NOT NULL,
    subject text NOT NULL,
    subject_namespace text, -- nullable because only valid if subject set
    subject_relation text -- again only applicable for subject sets
);
SQL

$db.execute <<-SQL
INSERT INTO tuples (object, object_namespace, relation, subject, subject_namespace, subject_relation) VALUES
    -- org:4#member@users:331
    ('4', 'org', 'member', '331', 'users', null),
    -- org:4#owner@users:333
    ('4', 'org', 'owner', '333', 'users', null),
    -- file:1#owner@org:4#owner
    ('1', 'file', 'owner', '4', 'org', 'member')
    ;
SQL

require "bundler/setup"
require "zanzibar"

require_relative 'file_policy'
require_relative 'org_policy'

p Zanzibar.check?("users", "333", "viewer", "file", "1")
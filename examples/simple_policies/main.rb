require "bundler/setup"
require "zanzibar"

require_relative 'csv_store'
require_relative 'file_policy'
require_relative 'org_policy'

p Zanzibar.check?("users", "333", "viewer", "file", "1")
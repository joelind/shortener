require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  should_have_db_index :href, :unique => true
  should_validate_uniqueness_of :href, :case_sensitive => :false
end

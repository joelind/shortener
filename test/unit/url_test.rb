require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  should_have_db_index :href, :unique => true
  should_validate_uniqueness_of :href, :case_sensitive => :false
  should_validate_presence_of :href

  should_allow_values_for :href, "http://www.foo.bar", "https://foo.bar"
  should_not_allow_values_for :href, "xxx", "123", "/aaa", "mailto:joelind@gmail.com"
end

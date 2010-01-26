require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  should_have_db_index :href, :unique => true
  should_validate_uniqueness_of :href, :case_sensitive => :false
  should_validate_presence_of :href

  should_allow_values_for :href, "http://www.foo.bar", "https://foo.bar"
  should_not_allow_values_for :href, "xxx", "123", "/aaa", "mailto:joelind@gmail.com"
  should_allow_mass_assignment_of :href

  test "find_by_encoded_id method" do
    encoded_id = Url.encoder.encode(1234)

    mock_url = Url.new
    Url.expects(:find_by_id).with(1234).returns(mock_url)

    returned_url = Url.find_by_encoded_id(encoded_id)

    assert_equal mock_url, returned_url
  end

  test "encoded_id method" do
    encoded_id = Url.encoder.encode(1234)
    url = Url.new
    url.stubs(:id => 1234)

    assert_equal encoded_id, url.encoded_id
  end

  test "to_param should return the encoded_id" do
    url = Url.new
    url.stubs :encoded_id => stub()

    assert_equal url.encoded_id, url.to_param
  end

  test "encoder method" do
    encoder = Url.encoder

    assert encoder.respond_to? :encode
    assert encoder.respond_to? :decode
  end

end

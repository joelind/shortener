require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should_belong_to :url
  context "A tag" do
    subject { @tag = Tag.create! :text => 'tag1', :url => Url.first }
    should_validate_uniqueness_of :text, :scoped_to => :url_id
  end
  should_have_db_index [:url_id, :text]
  should_have_db_index :text
  should_validate_presence_of :url
  should_validate_presence_of :text
end

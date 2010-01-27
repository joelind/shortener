require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should_belong_to :url
  context "A tag" do
    setup { @tag = Tag.create! :text => 'tag1', :url => Url.first }
    subject { @tag }
    should_validate_uniqueness_of :text, :scoped_to => :url_id
    should "be returned in the appropriate calls to the having_text_like scope" do
      assert Tag.having_text_like('tag').include?(@tag)
      assert Tag.having_text_like('TAG').include?(@tag)
      assert Tag.having_text_like('tAG1').include?(@tag)
      assert Tag.having_text_like('ag').include?(@tag)
      assert Tag.having_text_like('ag1').include?(@tag)

      assert !Tag.having_text_like('AA').include?(@tag)
      assert !Tag.having_text_like('somethingwithTAG1insideit').include?(@tag)
    end
  end
  should_have_db_index [:url_id, :text]
  should_have_db_index :text
  should_validate_presence_of :url
  should_validate_presence_of :text
end

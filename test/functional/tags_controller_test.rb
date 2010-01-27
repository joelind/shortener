require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  test "get to index with json format and a text_like parameter" do

    get :index, 'text_like' => 'some tag', 'format' => 'json'

    assert_response :success
  end
end

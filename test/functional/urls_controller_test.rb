require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  test "get to index" do
    get :index

    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:urls)
  end
end

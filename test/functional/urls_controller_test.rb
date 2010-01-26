require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  test "get to index" do
    get :index

    assert_response :success
    assert_template 'index'
  end

  test "get to new" do
    get :new
    assert_response :success
    assert_template 'new'
  end

  test "post to create when the url is not duplicated and save succeeds" do
    params = {'href' => 'http://www.foo.com'}
    stubbed_url = Url.new(params)
    stubbed_url.stubs(:save => true, :id => 10)
    Url.expects(:find_by_href).with(params['href']).returns(nil)
    Url.expects(:new).with(params).returns(stubbed_url)

    post :create, 'url' => params

    assert_redirected_to :action => 'show', :id => stubbed_url.to_param
  end

  test "post to create when the url is not duplicated and save fails" do
    params = {'href' => 'http://www.foo.com'}
    stubbed_url = Url.new(params)
    stubbed_url.stubs(:save => false, :id => 10)
    Url.expects(:find_by_href).with(params['href']).returns(nil)
    Url.expects(:new).with(params).returns(stubbed_url)

    post :create, 'url' => params

    assert_response :success
    assert_template :new
    assert_equal stubbed_url, assigns(:url_obj)
  end

  test "get to show for a non-existant url should return a 404" do
    Url.expects(:find_by_encoded_id).with('999').returns(nil)

    get :show, 'id' => '999'

    assert_response :not_found
    assert_nil assigns(:url_obj)
  end

  test "get to show for an existing url should succeed" do
    url = stub(:href => 'http://scvngr.com')
    Url.expects(:find_by_encoded_id).with('999').returns(url)

    get :show, 'id' => '999'

    assert_response :success
    assert_template 'show'
    assert_equal url, assigns(:url_obj)
  end

  test "get to redirect for an existant url should redirect to the appropriate href" do
    url = stub(:href => 'http://scvngr.com')
    Url.expects(:find_by_encoded_id).with('Ab123').returns(url)

    get :redirect, :id => 'Ab123'

    #moved permanently (301) is the right thing for this redirector since the current
    # implementation's urls are immutable
    assert_response :moved_permanently
    assert_redirected_to url.href
  end

  test "get to redirect for a non-existant url should return a 404" do
    Url.expects(:find_by_encoded_id).with('Ab123').returns(nil)

    get :redirect, :id => 'Ab123'

    assert_response :not_found
  end
end

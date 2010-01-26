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

    assert_response :unprocessable_entity
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
    url = Url.new(:href => 'http://scvngr.com')
    url.stubs(:id => 1, :created_at => Time.now)
    Url.expects(:find_by_encoded_id).with('999').returns(url)

    get :show, 'id' => '999'

    assert_response :success
    assert_template 'show'
    assert_equal url, assigns(:url_obj)
  end

  test "get to redirect for an existant url should redirect to the appropriate href" do
    url = Url.new(:href => 'http://scvngr.com')
    Url.expects(:find_by_encoded_id).with('Ab123').returns(url)

    get :redirect, :id => 'Ab123'

    assert_response 302
    assert_redirected_to url.href
  end

  test "get to redirect for a non-existant url should return a 404" do
    Url.expects(:find_by_encoded_id).with('Ab123').returns(nil)

    get :redirect, :id => 'Ab123'

    assert_response :not_found
  end

  test "get to edit for a non-existant url should return a 404" do
    Url.expects(:find_by_encoded_id).with('999').returns(nil)

    get :edit, 'id' => '999'

    assert_response :not_found
    assert_nil assigns(:url_obj)
  end

  test "get to edit for an existing url should succeed" do
    url = Url.new(:href => 'http://scvngr.com')
    Url.expects(:find_by_encoded_id).with('999').returns(url)

    get :edit, 'id' => '999'

    assert_response :success
    assert_template 'edit'
    assert_equal url, assigns(:url_obj)
  end

  test "put to update for a valid url that successfully validates should succeed" do
    url = Url.new(:href => 'http://scvngr.com')
    url.stubs(:id => 1, :save => true)
    Url.expects(:find_by_encoded_id).with(url.to_param).returns(url)
    params = {'href' => 'http://www.scvngr2.com'}
    url.expects(:update_attributes).with(params).returns(true)

    put :update, 'id' => url.to_param, 'url' => params

    assert_redirected_to :action => 'show', :id => url.to_param
  end

  test "put to update for a valid url that does not validate should render the edit action" do
    url = Url.new(:href => 'http://scvngr.com')
    url.stubs(:id => 1, :save => false)
    Url.expects(:find_by_encoded_id).with(url.to_param).returns(url)
    params = {'href' => 'http://www.scvngr2.com'}
    url.expects(:update_attributes).with(params).returns(false)

    put :update, 'id' => url.to_param, 'url' => params

    assert_response :unprocessable_entity
    assert_template 'edit'

  end

  test "put to update for a non-existant url should return a 404" do
    Url.expects(:find_by_encoded_id).with('999').returns(nil)

    put :update, 'id' => '999', 'url' => {}

    assert_response :not_found
  end

end

class UrlsController < ApplicationController
  before_filter :find_url, :only => [:show, :edit, :redirect, :update]
  def index
    @urls = Url.paginate(:page => params[:page], :per_page => 25, :order => 'created_at desc')
  end

  def new
    @url_obj = Url.new
  end

  def create
    @url_obj = Url.find_by_href(params['url']['href']) || Url.new(params['url'])
    if @url_obj.save
      flash[:notice_good] = "Congratulations, your url has been shortened"
      return redirect_to :action => :show, :id => @url_obj.to_param
    else
      render :action => :new, :status => :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def redirect
    # can't return a 301 since these are editable
    redirect_to @url_obj.href
  end

  def update
    @url_obj.update_attributes(params[:url])
    if @url_obj.save
      flash[:notice_good] = "Congratulations, your url has been updated"
      return redirect_to :action => :show, :id => @url_obj.to_param
    else
      render :action => :edit, :status => :unprocessable_entity
    end
  end

  private
  def find_url
    @url_obj = Url.find_by_encoded_id(params[:id])
    error_404 if @url_obj.nil?
  end

end

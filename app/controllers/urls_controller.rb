class UrlsController < ApplicationController
  def index
    @urls = Url.paginate(:page => params[:page], :per_page => 25, :order => 'created_at desc')
  end

  def new
    @url_obj = Url.new(:href => 'http://')
  end

  def create
    @url_obj = Url.find_by_href(params['url']['href']) || Url.new(params['url'])
    if @url_obj.save
      return redirect_to :action => :show, :id => @url_obj.to_param
    else
      render :action => :new
    end
  end

  def show
    @url_obj = Url.find_by_encoded_id(params[:id])
    return error_404 if @url_obj.nil?
  end

  def redirect
    @url_obj = Url.find_by_encoded_id(params[:id])
    if @url_obj.present?
      redirect_to @url_obj.href, :status => :moved_permanently
    else
      error_404
    end
  end

end

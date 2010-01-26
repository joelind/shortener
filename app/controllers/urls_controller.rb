class UrlsController < ApplicationController
  def index
    @urls = Url.paginate(:page => params[:page], :per_page => 25, :order => 'created_at desc')
  end

  def new
    @url_obj = Url.new
  end

  def create
    @url_obj = Url.find_by_href(params['url']['href']) || Url.new(params['url'])
    if @url_obj.save
      return redirect_to :action => :show, :id => @url_obj.id
    else
      render :action => :new
    end
  end

  def show
    @url_obj = Url.find_by_id(params[:id])
    return error_404 if @url_obj.nil?
  end
end

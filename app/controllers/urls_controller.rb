class UrlsController < ApplicationController
  def index
    @urls = Url.paginate(:page => params[:page], :per_page => 25, :order => 'created_at desc')
  end
end

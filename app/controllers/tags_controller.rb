class TagsController < ApplicationController
  def index
    @tags = Tag.text_only.having_text_like(params[:text_like]).scoped(:limit => 20)
    respond_to do |format|
      format.json { render :json => {:tags => @tags, :text_like => params[:text_like]}.to_json }
    end
  end
end

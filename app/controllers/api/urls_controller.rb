class Api::UrlsController < ApplicationController

	def create_short_url
    url = Url.new(:base_url => params[:base_url])
    if url.save
      render :json => {:success => true, :short_url => url.short_url}
    else
      render :json => {:success => false,:errors => url.errors.to_a.join(",")}
    end 
  end

  def get_short_url
  	url = Url.find_by_base_url(params[:base_url])
  	if url.present?
  	  render :json => {:success => true, :short_url => url.short_url}
  	else
  	  render :json => {:success => false,:errors => "Short url doesn't exist"}
  	end 
  end
end
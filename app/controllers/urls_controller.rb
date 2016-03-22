class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy]

  def index
    @urls = Url.all
  end

  def show
  end

  def new
    @url = Url.new
  end

  def redirect_method
    url = Url.find_by_short_value(params[:short_value])
    if url.present?
  	  redirect_to url.get_redirect_url
    else
      redirect_to urls_path
    end
  end

  def create
    @url = Url.new(url_params)

    respond_to do |format|
      if @url.save
        format.html { redirect_to @url, notice: 'Url was successfully created.' }
        format.json { render action: 'show', status: :created, location: @url }
      else
        format.html { render action: 'new' }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url }
      format.json { head :no_content }
    end
  end

  private
    def set_url
      @url = Url.find(params[:id])
    end

    def url_params
    	params[:url][:base_url] = params[:url][:base_url].strip
      params.require(:url).permit(:base_url, :short_url)
    end
end

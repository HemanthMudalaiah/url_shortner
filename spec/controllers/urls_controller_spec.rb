require 'rails_helper'
require 'spec_helper'

describe UrlsController do

	before(:each) { Url.delete_all }

	describe "GET #index" do
	  it "populates an array of urls" do
	    url = FactoryGirl.build(:url)
	    url.save
	    get :index
	    assigns(:urls).should eq([url])
	  end
	  
	  it "renders the :index view" do
	    get :index
	    response.should render_template :index
	  end
	end

	describe "GET #show" do
	  it "assigns the requested url" do
	    url = FactoryGirl.build(:url)
	    url.save
	    get :show, id: url
	    assigns(:url).should eq(url)
	  end
	  
	  it "renders the #show view" do
	  	url = FactoryGirl.build(:url)
	  	url.save
	    get :show, id: url
	    response.should render_template :show
	  end
	end

	describe "GET #new" do
	  it "assigns the new url" do
	    get :new
	    expect(assigns(:url)).to be_a_new(Url)
	  end
	end

	describe "POST create" do
	  context "with valid attributes" do
	    it "creates a new url" do
	      expect{
	        post :create, url: FactoryGirl.attributes_for(:url)
	      }.to change(Url,:count).by(1)
	    end
	    
	    it "redirects to the show page" do
	      post :create, url: FactoryGirl.attributes_for(:url)
	      response.should redirect_to Url.last
	    end
	  end
	  
	  context "with invalid attributes" do
	    it "does not save the new url" do
	      expect{
	        post :create, url: FactoryGirl.attributes_for(:invalid_url)
	      }.to_not change(Url,:count)
	    end
	    
	    it "re-renders the new method" do
	      post :create, url: FactoryGirl.attributes_for(:invalid_url)
	      response.should render_template :new
	    end
	  end 
	end

	describe 'DELETE destroy' do
	  before :each do
	    @url = FactoryGirl.build(:url)
	  	@url.save
	  end
	  
	  it "deletes the url" do
	    expect{
	      delete :destroy, id: @url       
	    }.to change(Url,:count).by(-1)
	  end
	    
	  it "redirects to urls#index" do
	    delete :destroy, id: @url
	    response.should redirect_to urls_url
	  end
	end

	describe 'Redirect to base url' do
		it "should redirect to base url if url exists" do
			url = FactoryGirl.build(:url)
	  	url.save
	  	get :redirect_method, {short_value: url.short_value}
	  	expect(response).to redirect_to(url.get_redirect_url)
		end

		it "should redirect to index if url doesn't exists" do
	  	get :redirect_method, {short_value: ""}
	  	expect(response).to redirect_to(urls_path)
		end
	end
end
require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::UrlsController, type: :controller do

	# before(:each) { Url.delete_all }

  describe "Create short url" do
    it "creates short_url if the base url is valid" do
    	Url.delete_all
      get :create_short_url, FactoryGirl.attributes_for(:url)
			expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['success']).to eq true
      expect(body['short_url']).not_to be_empty
    end

    it "doesn't create short_url if the base url is invalid" do
    	Url.delete_all
      get :create_short_url, FactoryGirl.attributes_for(:invalid_url)
			expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['success']).to eq false
      expect(body['errors']).not_to be_empty
    end

    it "doesn't create short_url if the base url is already taken" do
  	  url = FactoryGirl.build(:url, :base_url => 'www.abc.com')
  		url.save
      get :create_short_url, {:base_url => 'www.abc.com'}
			expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['success']).to eq false
      expect(body['errors']).not_to be_empty
    end
  end

  describe "Get short url" do
  	before(:each) { Url.delete_all }

    it "returns short_url if the base url exists" do
    	url = FactoryGirl.build(:url)
    	url.save
      get :get_short_url, FactoryGirl.attributes_for(:url)
			expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['success']).to eq true
      expect(body['short_url']).not_to be_empty
    end

    it "doesn't return short_url if the base url doesn't exists" do
      get :get_short_url, FactoryGirl.attributes_for(:url)
			expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['success']).to eq false
      expect(body['errors']).not_to be_empty
    end
  end
end

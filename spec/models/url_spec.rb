require 'rails_helper'
require 'spec_helper'

describe Url do

	before(:each) { Url.delete_all }

	context 'validates presence' do
	  it { should validate_presence_of :base_url }
	  it { should validate_uniqueness_of :base_url }
	end

	context 'validations on base url' do
	  it "should create a short url" do
	    url = FactoryGirl.build(:url)
	    url.should be_valid
	    expect(url.save!).to be true
	    expect(Url.all.count).to be ==  1
	  end

	  it "created short url shouldn't be empty" do
	    url = FactoryGirl.build(:url)
	    url.save
	    expect(url.short_url).not_to be_empty
	  end

	  it "should not create a short url" do
	    url = FactoryGirl.build(:url, :base_url => 'www.abc')
	    expect { url.save! }.to raise_error
	  end

	  it "should not create a short url" do
	    url = FactoryGirl.build(:url, :base_url => 'abc')
	    expect { url.save! }.to raise_error
	  end
	end	
end
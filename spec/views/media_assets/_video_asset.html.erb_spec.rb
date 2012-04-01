require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe "/media_assets/_video_asset.html.erb" do
  
  before :each do
    @asset = FactoryGirl.build(:video_asset)
  end
  
  it "should render the video element" do
    render :partial => "media_assets/video_asset", :locals => { :asset => @asset }
    rendered.should have_selector("div.media_element_wrapper.video_wrapper")
  end
end
require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe "/media_assets/_audio_asset.html.erb" do
  
  before :each do
    @asset = FactoryGirl.create(:audio_asset)
  end
  
  it "should render the audio element" do
    render :partial => "media_assets/audio_asset", :locals => { :asset => @asset }
    rendered.should have_selector("div.media_element_wrapper.audio_wrapper")
  end
end
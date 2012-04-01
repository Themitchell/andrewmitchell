require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe "/media_assets/_media_asset.html.erb" do
  
  before :each do
    @portfolio_item = FactoryGirl.create(:portfolio_item)
  end
  
  context "when there is no media asset" do
    it "should render a message for no content" do
      render :partial => 'media_asset', :locals => { :owner => @portfolio_item }
      rendered.should have_content "No media available for this item."
    end
  end
  
  context "when there is a media asset" do
    context "and the media asset is a video asset" do
      before :each do
        FactoryGirl.create(:video_asset, owner: @portfolio_item)
      end
    
      it "should render the video element" do
        render :partial => 'media_assets/media_asset', :locals => { :owner => @portfolio_item }
        view.should render_template(:partial => "_video_asset", :count => 1)
      end
    end
  
    context "and the media asset is an audio asset" do
      before :each do
        FactoryGirl.create(:audio_asset, owner: @portfolio_item)
      end
    
      it "should render the audio partial" do
        render :partial => 'media_assets/media_asset', :locals => { :owner => @portfolio_item }
        view.should render_template(:partial => "_audio_asset", :count => 1)
      end
    end
  end
end
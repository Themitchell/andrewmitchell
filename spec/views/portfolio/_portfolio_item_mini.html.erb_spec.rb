require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe "/portfolio/_portfolio_item_mini.html.erb" do
  
  before :each do
    @portfolio_item = FactoryGirl.create(:portfolio_item)
  end

  it "should render the item title" do
    render :partial => 'portfolio/portfolio_item_mini', :locals => { :portfolio_item_mini => @portfolio_item }
    rendered.should match("<h2>#{@portfolio_item.title}</h2>")
  end
  
  it "should render the item description" do
    render :partial => 'portfolio/portfolio_item_mini', :locals => { :portfolio_item_mini => @portfolio_item }
    rendered.should match("<p>#{@portfolio_item.description}</p>")
  end
  
  it "should render the media_template" do
    render :partial => 'portfolio/portfolio_item_mini', :locals => { :portfolio_item_mini => @portfolio_item }
    view.should render_template(:partial => "media_assets/_media_asset", :count => 1)
  end
end
require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe "/portfolio/index.html.erb" do
  before(:each) do
    @portfolio_items = []
    5.times { @portfolio_items << FactoryGirl.create(:portfolio_item) }
    assign(:portfolio_items, @portfolio_items)
  end

  it "should render all of the portfolio item templates" do
    render :template => "portfolio/index"
    view.should render_template(:partial => "_portfolio_item_mini", :count => 5)
  end
end
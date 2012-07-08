# require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe PortfolioController do

  describe '#index' do
    let!(:portfolio_item1) { FactoryGirl.create(:portfolio_item, :published_on => Time.now) }
    let!(:portfolio_item2) { FactoryGirl.create(:portfolio_item, :published_on => 24.hours.ago) }
    let!(:portfolio_item3) { FactoryGirl.create(:portfolio_item, :published_on => 24.hours.from_now) }
    before { get :index }
    it { should render_template :index }
    it { should assign_to(:portfolio_items).with([portfolio_item3, portfolio_item1, portfolio_item2]) }
  end

  describe "#show" do
    let(:portfolio_item) { FactoryGirl.create :portfolio_item }
    before { get :show, :id => portfolio_item.to_param}
    it { should assign_to(:portfolio_item).with(portfolio_item) }
  end

end

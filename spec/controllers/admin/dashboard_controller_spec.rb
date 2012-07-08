require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe Admin::DashboardController do
  it { controller.should be_a Admin::AdminController }
end

describe Admin::DashboardController, '#index' do

  context "with no user" do
    before do
      get :index
    end

    it { should redirect_to new_user_session_path }
  end

  context "when logged in" do
    before do
      sign_in FactoryGirl.create(:user)
      get :index
    end

    it { should redirect_to root_path }
  end

  context 'when logged in as an admin' do
    before do
      sign_in FactoryGirl.create(:admin)
      get :index
    end

    it { should render_with_layout('admin') }
    it { should render_template :index }
  end
end
require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe Admin::EmploymentHistoryItemsController do
  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in(admin) }
  it { should be_a(Admin::AdminController) }

  describe '#index' do
    let!(:employment_history_item1) { FactoryGirl.create(:employment_history_item, :created_at => Time.now) }
    let!(:employment_history_item2) { FactoryGirl.create(:employment_history_item, :created_at => 24.hours.ago) }
    let!(:employment_history_item3) { FactoryGirl.create(:employment_history_item, :created_at => 24.hours.from_now) }
    before { get :index }
    it { should render_template :index }
    it { should assign_to(:employment_history_items).with([employment_history_item3, employment_history_item1, employment_history_item2]) }
  end

  describe '#show' do
    let(:employment_history_item) { FactoryGirl.create(:employment_history_item)}
    before { get :show, :id => employment_history_item.to_param }
  end

  describe '#new' do
    before { get :new }
    it { should assign_to(:employment_history_item).with_kind_of(EmploymentHistoryItem) }
    it { should render_template :new }
  end

  describe '#create' do
    context "with valid params" do
      let(:valid_params) { FactoryGirl.attributes_for(:employment_history_item) }
      before { expect { post :create, :employment_history_item => valid_params }.to change(EmploymentHistoryItem, :count).by(1) }
      it { should assign_to(:employment_history_item).with_kind_of(EmploymentHistoryItem) }
      it { should redirect_to admin_employment_history_item_path EmploymentHistoryItem.last }
    end
    context "with invalid params" do
      before { expect { post :create, :employment_history_item => {} }.not_to change(EmploymentHistoryItem, :count) }
      it { should render_template :new }
    end
  end

  describe '#edit' do
    let(:employment_history_item) { FactoryGirl.create(:employment_history_item) }
    before { get :edit, :id => employment_history_item.to_param }
    it { should assign_to(:employment_history_item).with(employment_history_item) }
    it { should render_template :edit }
  end

  describe '#update' do
    let!(:expected_employment_history_item) { FactoryGirl.create(:employment_history_item) }
    context "with valid params" do
      before { expect { put :update, :id => expected_employment_history_item.to_param, :employment_history_item => FactoryGirl.attributes_for(:employment_history_item) }.not_to change(EmploymentHistoryItem, :count) }
      it { should assign_to(:employment_history_item).with(expected_employment_history_item) }
      it { should redirect_to admin_employment_history_item_path(expected_employment_history_item) }
    end
    context "with invalid params" do
      before { expect { put :update, :id => expected_employment_history_item.to_param, :employment_history_item => { :company_name => nil } }.not_to change(EmploymentHistoryItem, :count) }
      it { should assign_to(:employment_history_item).with(expected_employment_history_item) }
      it { should render_template :edit }
    end
  end

  describe '#destroy' do
    let!(:deletable_employment_history_item) { FactoryGirl.create(:employment_history_item) }
    before { delete :destroy, :id => deletable_employment_history_item.to_param }
    it { should assign_to(:employment_history_item).with(deletable_employment_history_item) }
    it { should redirect_to admin_employment_history_items_path }
  end
end


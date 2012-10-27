require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe Admin::CategoriesController do
  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in(admin) }
  it { should be_a(Admin::AdminController) }

  describe '#index' do
    let!(:category1) { FactoryGirl.create(:category, :created_at => Time.now) }
    let!(:category2) { FactoryGirl.create(:category, :created_at => 24.hours.ago) }
    let!(:category3) { FactoryGirl.create(:category, :created_at => 24.hours.from_now) }
    before { get :index }
    it { should render_template :index }
    it { should assign_to(:categories).with([category3, category1, category2]) }
  end

  describe '#show' do
    let(:category) { FactoryGirl.create(:category)}
    before { get :show, :id => category.to_param }
  end

  describe '#new' do
    before { get :new }
    it { should assign_to(:category).with_kind_of(Category) }
    it { should render_template :new }
  end

  describe '#create' do
    context "with valid params" do
      let(:valid_params) { FactoryGirl.attributes_for(:category) }
      before { expect { post :create, :category => valid_params }.to change(Category, :count).by(1) }
      it { should assign_to(:category).with_kind_of(Category) }
      it "should assign the current user as the author" do assigns(:category).author.should == admin end
      it { should redirect_to admin_category_path Category.last }
    end
    context "with invalid params" do
      before { expect { post :create, :category => {} }.not_to change(Category, :count) }
      it { should render_template :new }
    end
  end

  describe '#edit' do
    let(:category) { FactoryGirl.create(:category) }
    before { get :edit, :id => category.to_param }
    it { should assign_to(:category).with(category) }
    it { should render_template :edit }
  end

  describe '#update' do
    let!(:expected_category) { FactoryGirl.create(:category) }
    context "with valid params" do
      before { expect { put :update, :id => expected_category.to_param, :category => FactoryGirl.attributes_for(:category) }.not_to change(Category, :count) }
      it { should assign_to(:category).with(expected_category) }
      it { should redirect_to admin_category_path(expected_category.reload) }
    end
    context "with invalid params" do
      before { expect { put :update, :id => expected_category.to_param, :category => { :name => nil } }.not_to change(Category, :count) }
      it { should assign_to(:category).with(expected_category) }
      it { should render_template :edit }
    end
  end

  describe '#destroy' do
    let!(:deletable_category) { FactoryGirl.create(:category) }
    before { delete :destroy, :id => deletable_category.to_param }
    it { should assign_to(:category).with(deletable_category) }
    it { should redirect_to admin_categories_path }
  end
end


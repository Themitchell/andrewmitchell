require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe Admin::PostsController do
  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in(admin) }
  it { should be_a(Admin::AdminController) }

  describe '#index' do
    let(:post1) { FactoryGirl.create(:post, :created_at => Time.now) }
    let(:post2) { FactoryGirl.create(:post, :created_at => 24.hours.ago) }
    let(:post3) { FactoryGirl.create(:post, :created_at => 24.hours.from_now) }
    before { get :index }
    it { should render_template :index }
    it { should assign_to(:posts).with([post3, post1, post2]) }
  end

  describe '#new' do
    before { get :new }
    it { should assign_to(:post).with_kind_of(Post) }
    it { should render_template :new }
  end

  describe '#create' do
    let(:category) { FactoryGirl.create(:category) }
    context "with valid params" do
      before { post :create, :post => FactoryGirl.attributes_for(:post).merge!(:category_id => category.id) }
      # it { should change(Post.count).by(1) }
      it { should redirect_to post_path Post.last }
    end
    context "with invalid params" do
      before { post :create, :post => {} }
      it { should render_template :new }
    end
  end

  describe '#edit' do
    let(:post) { FactoryGirl.create(:post) }
    before { get :edit, :id => post.to_param }
    it { should assign_to(:post).with(post) }
    it { should render_template :edit }
  end

  describe '#update' do
    let(:expected_post) { FactoryGirl.create(:post) }
    context "with valid params" do
      before do
        post :update, :id => expected_post.to_param, :post => { :title => 'edited' }
      end
      it { should assign_to(:post).with(expected_post) }
      it { should redirect_to post_path(expected_post) }
    end
    context "with invalid params" do
      before do
        post :update, :id => expected_post.to_param, :post => { :title => "" }
      end
      it { should render_template :edit }
    end
  end

  describe '#destroy' do
    let(:deletable_post) { FactoryGirl.create(:post) }
    before { delete :destroy, :id => deletable_post.to_param }
    # it { should change "Post.count", :by => -1 }
    it { should redirect_to admin_posts_path }
  end
end


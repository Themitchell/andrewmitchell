require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe Admin::PostsController do  
  before do
    @admin = FactoryGirl.create(:admin)
    sign_in(@admin)
  end

  it { should be_a(Admin::AdminController) }

  describe '#index' do
    before do
      get :index
    end

    it { should render_template :index }
  end

  describe'#show' do
    before do
      @post = FactoryGirl.create(:post)
      get :show, :id => @post.to_param
    end

    it { should assign_to(:post).with(@post) }
    it { should render_template :show }
  end


  describe '#new' do
    before do
      get :new
    end

    it { should assign_to(:post).with_kind_of(Post) }
    it { should render_template :new }
  end

  describe '#create' do
    before do
      @category = FactoryGirl.create(:category)
    end

    context "with valid params" do
      before do
        valid_params = FactoryGirl.attributes_for(:post)
        valid_params.merge!(:category_id => @category.id)
        expect { post :create, :post => valid_params }.to change(Post, :count).by(1)
        @post = Post.last
      end

      it { should redirect_to admin_post_path(@post) }
      it "should set the author" do
        @post.author.should == @admin
      end
    end

    context "with invalid params" do
      before do
        post :create, :post => {}
      end

      it { should render_template :new }
    end
  end

  describe '#edit' do
    before do
      @post = FactoryGirl.create(:post)
      get :edit, :id => @post.to_param
    end

    it { should assign_to(:post).with(@post) }
    it { should render_template :edit }
  end

  describe '#update' do
    before do
      @post = FactoryGirl.create(:post)
    end

    context "with valid params" do
      before do
        valid_params = { :id => @post.to_param, :post => { :title => 'edited' } }
        post :update, valid_params
        @post.reload
      end

      it { should redirect_to admin_post_path(@post) }
      it "should set the author" do
        @post.author.should == @admin
      end
    end

    context "with invalid params" do
      before do
        post :update, :id => @post.to_param, :post => { :title => "" }
      end

      it { should render_template :edit }
    end
  end

  describe '#destroy' do
    before do
      @post = FactoryGirl.create(:post)
      expect { delete :destroy, :id => @post.to_param }.to change(Post, :count).by(-1)
    end

    it { should redirect_to admin_posts_path }
  end
end


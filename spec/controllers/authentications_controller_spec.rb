# require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')
# 
# describe AuthenticationsController do
# 
#   describe "GET 'index'" do
#     context "when logged in" do
#       before :each do
#         @user = FactoryGirl.build(:user)
#         controller.stub(:current_user).and_return(@user)
#       end
# 
#       it "returns http success" do
#         get :index
#         response.should be_success
#       end
#     end
#   end
# 
#   describe "GET 'create'" do
#     context "when logged in" do
#       before :each do
#         @user = FactoryGirl.build(:user)
#         controller.stub(:current_user).and_return(@user)
#       end
# 
#       it "returns http success" do
#         post :create, :provider => "twitter"
#         response.should be_success
#       end
#     end
#   end
# 
#   describe "GET 'destroy'" do
#     context "when logged in" do
#       before :each do
#         @user = FactoryGirl.build(:user)
#         controller.stub(:current_user).and_return(@user)
#         @auth = FactoryGirl.build(:authentication, :user => @user)
#       end
# 
#       it "returns http success" do
#         delete :destroy, :provider => @auth.provider
#         response.should be_success
#       end
#     end
#   end
# end

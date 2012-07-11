require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe Admin::EducationalQualificationsController do
  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in(admin) }
  it { should be_a(Admin::AdminController) }

  describe '#index' do
    let!(:educational_qualification1) { FactoryGirl.create(:educational_qualification, :created_at => Time.now) }
    let!(:educational_qualification2) { FactoryGirl.create(:educational_qualification, :created_at => 24.hours.ago) }
    let!(:educational_qualification3) { FactoryGirl.create(:educational_qualification, :created_at => 24.hours.from_now) }
    before { get :index }
    it { should render_template :index }
    it { should assign_to(:educational_qualifications).with([educational_qualification3, educational_qualification1, educational_qualification2]) }
  end

  describe '#show' do
    let(:educational_qualification) { FactoryGirl.create(:educational_qualification)}
    before { get :show, :id => educational_qualification.to_param }
  end

  describe '#new' do
    before { get :new }
    it { should assign_to(:educational_qualification).with_kind_of(EducationalQualification) }
    it { should render_template :new }
  end

  describe '#create' do
    context "with valid params" do
      let(:valid_params) { FactoryGirl.attributes_for(:educational_qualification) }
      before { expect { post :create, :educational_qualification => valid_params }.to change(EducationalQualification, :count).by(1) }
      it { should assign_to(:educational_qualification).with_kind_of(EducationalQualification) }
      it { should redirect_to admin_educational_qualification_path EducationalQualification.last }
    end
    context "with invalid params" do
      before { expect { post :create, :educational_qualification => {} }.not_to change(EducationalQualification, :count) }
      it { should render_template :new }
    end
  end

  describe '#edit' do
    let(:educational_qualification) { FactoryGirl.create(:educational_qualification) }
    before { get :edit, :id => educational_qualification.to_param }
    it { should assign_to(:educational_qualification).with(educational_qualification) }
    it { should render_template :edit }
  end

  describe '#update' do
    let!(:expected_educational_qualification) { FactoryGirl.create(:educational_qualification) }
    context "with valid params" do
      before { expect { put :update, :id => expected_educational_qualification.to_param, :educational_qualification => FactoryGirl.attributes_for(:educational_qualification) }.not_to change(EducationalQualification, :count) }
      it { should assign_to(:educational_qualification).with(expected_educational_qualification) }
      it { should redirect_to admin_educational_qualification_path(expected_educational_qualification) }
    end
    context "with invalid params" do
      before { expect { put :update, :id => expected_educational_qualification.to_param, :educational_qualification => { :name => nil } }.not_to change(EducationalQualification, :count) }
      it { should assign_to(:educational_qualification).with(expected_educational_qualification) }
      it { should render_template :edit }
    end
  end

  describe '#destroy' do
    let!(:deletable_educational_qualification) { FactoryGirl.create(:educational_qualification) }
    before { delete :destroy, :id => deletable_educational_qualification.to_param }
    it { should assign_to(:educational_qualification).with(deletable_educational_qualification) }
    it { should redirect_to admin_educational_qualifications_path }
  end
end


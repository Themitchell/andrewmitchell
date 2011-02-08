require 'spec_helper'

describe Photoalbum do
  describe "validations" do
    it "should be invalid without a name" do
      pa = Factory.build(:photoalbum, :name => nil)
      pa.should_not be_valid
      pa.errors[:name].should_not be_empty
    end 
    
    it "should be invalid with a name as an empty string" do
      pa = Factory.build(:photoalbum, :name => "")
      pa.should_not be_valid
      pa.errors[:name].should_not be_empty
    end
    
    it "should be invalid with a name that already exists" do
      Factory.create(:photoalbum, :name => "a photoalbum")
      pa = Factory.build(:photoalbum, :name => "a photoalbum")
      pa.should_not be_valid
      pa.errors[:name].should_not be_empty
    end
    
    it "should be invalid without a description" do
      pa = Factory.build(:photoalbum, :description => nil)
      pa.should_not be_valid
      pa.errors[:description].should_not be_empty
    end 
    
    it "should be invalid with a description as an empty string" do
      pa = Factory.build(:photoalbum, :description => "")
      pa.should_not be_valid
      pa.errors[:description].should_not be_empty
    end
    
    it "should be invalid without a published_on date" do
      pa = Factory.build(:photoalbum, :published_on => nil)
      pa.should_not be_valid
      pa.errors[:published_on].should_not be_empty
    end 
    
    it "should be invalid with a published_on date as an empty string" do
      pa = Factory.build(:photoalbum, :published_on => "")
      pa.should_not be_valid
      pa.errors[:published_on].should_not be_empty
    end
    
    it "should be invalid without an author" do
      pa = Factory.build(:photoalbum, :author => nil)
      pa.should_not be_valid
      pa.errors[:author].should_not be_empty
    end
  end
  
  describe "associations" do
    it "should belong to user" do
      user = Factory.create(:user)
      pa = Factory.create(:photoalbum, :author => user)
      pa.author.should == user
    end
    
    it "should have many pictures" do
      pa = Factory.create(:photoalbum)
      p = Factory.create(:picture, :photoalbum => pa)
      pa.pictures.should == [p]
    end
  end
end
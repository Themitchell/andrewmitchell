require File.expand_path(File.dirname(__FILE__) + '../../support/acceptance_helper')

feature "Photo Albums Pages", %q{
  In order to look at my pictures
  As a user
  I want to view a my pictures
} do

  background do
    @pa1 = FactoryGirl.create(:photoalbum)
  end

  scenario "no pictures in an album" do
        
    visit photoalbum_path(@pa1)
    
    page.should have_content("There are currently no pictures.")
  end
  
  scenario "1 picture in an album" do
    pic = FactoryGirl.create(:picture,
      title: "A picture",
      published_on: "01-01-2010",
      description: "picture description",
      tag_list: "Apple, Ableton",
      photoalbum: @pa1
    )
    visit photoalbum_path(@pa1)

    within :xpath, "//ol[@class='list']" do    
      within :xpath, "li[1]" do
        page.should have_content("A picture")
        image = page.find("img")
        image[:src].should match(/picture.jpg/)
        image[:src].should match(/\/preview\//)
        
        click_link pic.title
      end
    end
    
    current_path.should == photoalbum_picture_path(@pa1.to_param, pic.to_param)
    
    page.should have_content("A picture")
    
    image = page.find("img")
    image[:src].should match(/picture.jpg/)
    image[:src].should match(/\/picture\//)
    
    page.should have_content("picture description")
    page.should have_content("1 January, 2010")
    page.should have_content("Apple")
    page.should have_content("Ableton")
  end
  
  scenario "pagination on the pictures index" do
    pictures = []
    20.times do |n|
      pictures << FactoryGirl.create(:picture, photoalbum: @pa1, published_on: 30.days.ago+n.days)
    end
    old_pic = FactoryGirl.create(:picture, photoalbum: @pa1, published_on: 1.year.ago)
    
    visit photoalbum_path(@pa1)
    
    pictures.each do |pic|
      page.should have_content(pic.title)
    end
    page.should_not have_content(old_pic.title)
  end
  
  scenario "pagination on the photoalbums index" do
    Photoalbum.destroy_all
    photoalbums = []
    20.times do |n|
      album = FactoryGirl.create(:photoalbum, published_on: 30.days.ago+n.days)
      photoalbums <<  album
    end
    old_pa = FactoryGirl.create(:photoalbum, published_on: 1.year.ago)
    
    visit photoalbums_path
    
    photoalbums.each do |pa|
      page.should have_content(pa.name)
    end
    page.should_not have_content(old_pa.name)
  end
end
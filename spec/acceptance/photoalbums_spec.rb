require File.expand_path(File.dirname(__FILE__) + '../../support/acceptance_helper')

feature "Photo Albums Pages", %q{
  In order to organise my photoalbums
  As a user
  I want to view photoalbums
} do

  scenario "no albums" do
    visit photoalbums_path
    page.should have_content("There are currently no photo albums.")
  end
  
  scenario "1 album" do
    pa = FactoryGirl.create(:photoalbum,
      name: "A photoalbum",
      published_on: "01-01-2010",
      description: "photoalbum description"
    )
    pic = FactoryGirl.create(:picture, photoalbum: pa, picture_file_name: "blah.jpg")
    visit photoalbums_path

    within :xpath, "//ol[@class='list']" do    
      within :xpath, "li[1]" do
        page.should have_content("A photoalbum")
        image = page.find("img")
        image[:src].should match(/blah.jpg/)
        image[:src].should match(/\/preview\//)
        
        click_link "A photoalbum"
      end
    end
    
    current_path.should == photoalbum_path(pa.to_param)
    
    page.should have_content("A photoalbum")
    image = page.find("img")
    image[:src].should match(/blah.jpg/)
    image[:src].should match(/\/preview\//)
    page.should have_content("photoalbum description")
    page.should have_content("Andrew Mitchell")
    page.should have_content("1 January, 2010")
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
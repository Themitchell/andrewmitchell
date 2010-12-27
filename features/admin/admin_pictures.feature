Feature: Managing Pictures
	In order to manage pictures
	As an admin
	I would like to be able to create edit and delete pictures
	
	Background:
		Given user "Andrew Mitchell" exists with role: "admin", username: "Andrew Mitchell", password: "password", password_confirmation: "password", email: "admin@example.com"
		And I am logged in as "Andrew Mitchell"
		
	Scenario: Admin index
		Given picture "Picture title" exists with title: "Picture title", picture_file_name: "picture.jpg", published_on: "2010-01-14", author: user "Andrew Mitchell"
		And I am on the admin picture index
		And I should see a "thumbnail" size image with file name "picture.jpg" and alt tag "Picture title"
		Then I should see "Picture title"

		When I follow "Show"
		Then I should be on the admin show page for picture "Picture title"
		When I follow "Back to Pictures"
		Then I should be on the admin picture index
		When I follow "Edit"
		Then I should be on the admin edit page for picture "Picture title"
		When I follow "Back to Pictures"
		Then I should be on the admin picture index
		When I follow "Delete"
		Then I should be on the admin picture index
		And I should not see "Picture title"
	
	Scenario: Creating a picture
		When I go to the admin new picture page
		When I fill in "Title:" with "New Picture"
		And I attach the file at "features/support/images/picture.jpg" to "Picture:"
		And I fill in "Tag List:" with "Apple, Ableton"
		And I fill in "Published On:" with "23 May, 2010"
		And I press "Save"
		Then I should be on the admin show page for picture "New Picture"
		Then I should see "New Picture"
		And I should see a "picture" size image with file name "picture.jpg" and alt tag "New Picture"
		And I should see "Andrew Mitchell"
		And I should see "23 May, 2010"
		And I should see "Apple"
		And I should see "Ableton"
		And I should see "Picture successfully created."
		
	Scenario: Editing a picture
		Given picture "Picture" exists with title: "Picture", picture_file_name: nil, published_on: "2010-01-14", author: user "Andrew Mitchell", tag_list: "Apple"
		When I go to the admin edit page for picture "Picture"
		Then the "Title:" field should contain "Picture"
		And I should see a "picture" size image with file name "picture.jpg" and alt tag "Picture"
		And the "Tag List:" field should contain "Apple"
		And "Andrew Mitchell" should be selected for "Author:"
		And the "Published On:" field should contain "2010-01-14"
		When I fill in "Title:" with "Edited Picture"
		And I fill in "Tag List:" with "Ableton, iPod"
		And I fill in "Published On:" with "23 May, 2010"
		And I press "Save"
		Then I should be on the admin show page for picture "Edited Picture"
		Then I should see "Edited Picture"
		And I should see a "picture" size image with file name "picture.jpg" and alt tag "Edited Picture"
		And I should see "Andrew Mitchell"
		And I should see "23 May, 2010"
		And I should see "Ableton"
		And I should see "iPod"
		
	Scenario: Deleting a picture
		Given picture "Picture" exists with title: "Picture", picture_file_name: "picture.jpg", published_on: "2010-01-14", author: user "Andrew Mitchell"
		And I am on the admin show page for picture "Picture"
		When I follow "Delete Picture"
		Then I should be on the admin picture index
		And I should not see "A Picture"
		
		
		
		

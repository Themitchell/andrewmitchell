Feature: Managing Posts
	In order to manage posts
	As an admin
	I would like to be able to create edit and delete posts
	
	Background:
		Given user "Andrew Mitchell" exists with role: "admin", username: "Andrew Mitchell", password: "password", password_confirmation: "password", email: "admin@example.com"
		And I am logged in as "Andrew Mitchell"
		
	Scenario: Admin index
		Given a post exists with title: "Post title", body: "Post body.", published_on: "2010-01-14", author: user "Andrew Mitchell"
		And I am on the admin post index
		Then I should see "Post title"
		And I should see "Andrew Mitchell"
		And I should see "14 January, 2010"

		When I follow "Show"
		Then I should be on the admin show page for post "Post title"
		When I follow "Back to Posts"
		Then I should be on the admin post index
		When I follow "Edit"
		Then I should be on the admin edit page for post "Post title"
		When I follow "Back to Posts"
		Then I should be on the admin post index
		When I follow "Delete"
		Then I should be on the admin post index
		And I should not see "Post title"
	
	Scenario: Creating a post
		When I go to the admin new post page
		When I fill in "Title:" with "New Post"
		And I fill in "Body:" with "This is my post."
		And I fill in "Tag List:" with "Apple, Ableton"
		And I fill in "Published On:" with "23 May, 2010"
		And I press "Save"
		Then I should be on the admin show page for post "New Post"
		Then I should see "New Post"
		And I should see "This is my post."
		And I should see "Andrew Mitchell"
		And I should see "23 May, 2010"
		And I should see "Apple"
		And I should see "Ableton"
		And I should see "Post successfully created."
		
	Scenario: Editing a post
		Given a post exists with title: "Post", body: "Post body.", published_on: "2010-01-14", author: user "Andrew Mitchell", tag_list: "Apple"
		When I go to the admin edit page for post "Post"
		Then the "Title:" field should contain "Post"
		And the "Body:" field should contain "Post body."
		And the "Tag List:" field should contain "Apple"
		And "Andrew Mitchell" should be selected for "Author:"
		And the "Published On:" field should contain "2010-01-14"
		When I fill in "Title:" with "Edited Post"
		And I fill in "Body:" with "Edited post body."
		And I fill in "Tag List:" with "Ableton, iPod"
		And I fill in "Published On:" with "23 May, 2010"
		And I press "Save"
		Then I should be on the admin show page for post "Edited Post"
		Then I should see "Edited Post"
		And I should see "Edited post body."
		And I should see "Andrew Mitchell"
		And I should see "Ableton"
		And I should see "iPod"
		And I should see "23 May, 2010"
		
	Scenario: Deleting a post
		Given a post exists with title: "Post", body: "Post body.", published_on: "2010-01-14", author: user "Andrew Mitchell"
		And I am on the admin show page for post "Post"
		When I follow "Delete Post"
		Then I should be on the admin post index
		And I should not see "A Post"
		
		
		
		
		
Feature: Comments on blog Index
	In order to see comments posts
	As a reader
	I want to view comments related to a post on the blog index
	
	Background: 
		Given user "Andrew Mitchell" exists with role: "admin", username: "Andrew Mitchell", password: "password", password_confirmation: "password", email: "admin@example.com"
		And user "Zoe Mitchell" exists with role: "member", username: "Zoe Mitchell", password: "password", password_confirmation: "password", email: "member@example.com"
		And post "A Post" exists with title: "A post", body: "Post body.", author: user "Andrew Mitchell"
		And picture "A Picture" exists with title: "A picture", picture_file_name: "picture.jpg", author: user "Andrew Mitchell"

	Scenario: non user cannot see comment form
		Given comment "comment 1" exists with body: "foo", author: user "Zoe Mitchell", commentable: post "A Post"
		Given I am on the page for post "A post"
		Then I should not see "Add Comment"
		And I should not see "Delete"
		
		Given comment "comment 2" exists with body: "foo", author: user "Zoe Mitchell", commentable: picture "A Picture"
		Given I am on the page for picture "A picture"
		Then I should not see "Add Comment"
		And I should not see "Delete"
		
	Scenario: member can comment on post
		Given I am logged in as "Zoe Mitchell"
		And I am on the page for post "A post"
		And I follow "Add Comment"
		Then I should be on the new comment page for post "A post"
		And I fill in "Comment:" with "Your post is rubbish"
		And I press "Save"
		Then I should be on the page for post "A post"
		And I should see "Comment successfully created."
		And I should see an image with file name "blank_avatar.gif" and alt tag "Zoe Mitchell"
		And I should see "Zoe Mitchell" in the comments section
		And I should see "Your post is rubbish" in the comments section
		And I should not see "Delete" in the comments section
		
	Scenario: member can comment on picture
		Given I am logged in as "Zoe Mitchell"
		And I am on the page for picture "A picture"
		And I follow "Add Comment"
		Then I should be on the new comment page for picture "A picture"
		And I fill in "Comment:" with "Your picture is rubbish"
		And I press "Save"
		Then I should be on the page for picture "A picture"
		And I should see "Comment successfully created."
		And I should see an image with file name "blank_avatar.gif" and alt tag "Zoe Mitchell"
		And I should see "Zoe Mitchell" in the comments section
		And I should see "Your picture is rubbish" in the comments section
		And I should not see "Delete" in the comments section
		
	Scenario: admin can remove comments directly from a blog page
		Given I am logged in as "Andrew Mitchell"
		And comment "Your post is rubbish" exists with body: "Your post is rubbish", author: user "Zoe Mitchell", commentable: post "A Post"
		And I am on the page for post "A Post"
		When I follow "Delete" in the comments section
		Then I should be on the page for post "A Post"
		And I should see "Comment successfully removed."
		And I should not see "Zoe Mitchell" in the comments section
		And I should not see "Your post is rubbish" in the comments section
	
	Scenario: admin can remove comments directly from a picture page
		Given I am logged in as "Andrew Mitchell"
		And comment "Your picture is rubbish" exists with body: "Your picture is rubbish", author: user "Zoe Mitchell", commentable: picture "A Picture"
		And I am on the page for picture "A Picture"
		When I follow "Delete" in the comments section
		Then I should be on the page for picture "A Picture"
		And I should see "Comment successfully removed."
		And I should not see "Zoe Mitchell" in the comments section
		And I should not see "Your post is rubbish" in the comments section
		
Feature: Blog Index
	In order to see the most relevant posts
	As a reader
	I want the 5 most recent posts on the front page
	
	Scenario: No posts in blog
		Given I am on the homepage
		Then I should see "There are currently no posts."

	Scenario: 1 post in blog
		Given user "Andrew Mitchell" exists with role: "admin", username: "Andrew Mitchell", password: "password", password_confirmation: "password", email: "admin@example.com"
		And post "My Post" exists with title: "My Post", body: "This is my post.", author: user "Andrew Mitchell", published_on: "22 May, 2010", tag_list: "Apple, Ableton"		
		
		When I go to the homepage
		Then I should see "My Post"
		And I should see "This is my post."
		And I should see "Andrew Mitchell"
		And I should see "22 May, 2010"
		And I follow "My Post"
		Then I should be on the page for post "My Post"
		Then I should see "My Post"
		And I should see "This is my post."
		And I should see "Andrew Mitchell"
		And I should see "Apple"
		And I should see "Ableton"
		And I should see "22 May, 2010"
		
		
	Scenario: Pagination on the blog index
    Given the following posts exist:
      | title  | body		| published_on |
      | Post 1 | A post.| 2010-04-01   |
      | Post 2 | w00		| 2010-04-01   |
      | Post 3 | stuff  | 2010-04-01   |
      | Post 4 | and		| 2010-04-01   |
      | Post 5 | things	| 2010-04-01   |
    When I go to the home page
    Then I should see "Post 1"
    Then I should see "Post 2"
    Then I should see "Post 3"
    Then I should see "Post 4"
    Then I should see "Post 5"
	
Feature: Navigation
	In order to move around the site
	As a reader
	I want to be able to use the nav bar
	
	Background:
		Given I am on the homepage
	
	Scenario:
		When I follow "Blog"
		Then I should be on the post index page
		
		When I follow "Pictures"
		Then I should be on the picture index page
		
		
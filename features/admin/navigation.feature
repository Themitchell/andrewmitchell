Feature: Navigation
	In order to adminstrate
	As an admin
	I want to be able to use the admin nav bar
	
	Background:
		Given user "Andrew Mitchell" exists with role: "admin", username: "Andrew Mitchell", password: "password", password_confirmation: "password", email: "admin@example.com"
		And I am logged in as "Andrew Mitchell"
		And I am on the admin homepage
	
	Scenario:
		When I follow "Users"
		Then I should be on the admin user index page
	
		When I follow "Blog"
		Then I should be on the admin post index page
		
		When I follow "Pictures"
		Then I should be on the admin picture index page
		

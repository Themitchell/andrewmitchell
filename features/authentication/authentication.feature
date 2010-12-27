Feature: Authentication
	In order to create posts
	As an admin
	I want to be able to log in
	
	Background:
		Given a user with email "user@example.com" and password "password"

	Scenario: Logging in
		When I go to the home page
		And I follow "Sign in"
		Then I should be on the login page
		
		When I fill in "Email" with "user@example.com"
		And I fill in "Password" with "password"
		And I press "Sign in"
		Then I should be logged in
		
	Scenario: Logging out
		Given I am logged in
		When I follow "Sign out"
		Then I should be logged out
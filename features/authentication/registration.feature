Feature: Registration
	In order to comment
	As a user
	I want to be able to register and login
	
	Scenario: registering a new user with sufficient details
		When I go to the home page
		And I follow "Sign up"
		Then I should be on the sign up page
		When I fill in "Username:" with "Username"
		And I fill in "Email:" with "user@example.com"
		And I fill in "Password:" with "password"
		And I fill in "Password Confirmation:" with "password"
		And I press "Save"
		Then there should be a user with username "Username"
		And I should see "User successfully created."
		
	Scenario: registering a new user all details
		When I go to the home page
		And I follow "Sign up"
		Then I should be on the sign up page
		When I fill in "Username:" with "Username"
		And I fill in "Email:" with "user@example.com"
		And I fill in "Password:" with "password"
		And I fill in "Password Confirmation:" with "password"
		And I attach the file at "features/support/images/image.jpg" to "Avatar:"
		And I fill in "First Name:" with "Amanda"
		And I fill in "Last Name:" with "Hugenkiss"
		And I fill in "Website Url:" with "http://www.bbc.co.uk"
		And I fill in "Date of Birth:" with "01-01-1980"
		And I press "Save"
		Then there should be a user with username "Username"
		And I should see "User successfully created."
		
	Scenario: registering a new user with insufficient details
		When I go to the home page
		And I follow "Sign up"
		Then I should be on the sign up page
		And I press "Save"
		Then there should not be a user with username "Username"
		And I should see "Email can't be blank"
		And I should see "Password can't be blank"
		
	Scenario: Edit user name and email and avatar
		Given a user "Username" exists with username: "Username", email: "user@example.com", password: "password", password_confirmation: "password"
		And I am logged in as "Username"
		And I am on the edit page for user "Username"
		And I attach the file at "features/support/images/image.jpg" to "Avatar:"
		And I fill in "First Name:" with "Andrew"
		And I fill in "Last Name:" with "Mitchell"
		And I fill in "Email:" with "username@example.com"
		And I press "Save"
		Then I should be on the show page for user "Username"
		And I should see "User successfully updated."
		And I should see "Username - Username"
		Then I should see an "avatar" size image with file name "image.jpg" and alt tag "Username"
		And I should see "Name: Andrew Mitchell"
		And I should see "Email: username@example.com"
		When I go to the edit page for user "Username"
		And I press "Remove"
		Then I should be on the show page for user "Username"
		And I should see an image with file name "blank_avatar.gif" and alt tag "Username"
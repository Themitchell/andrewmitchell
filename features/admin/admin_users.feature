Feature: Registration & Login
	In to change roles etc
	As a superadmin
	I want to be able to edit a user

	Scenario: Changing a users role
		Given user "Andrew Mitchell" exists with role: "superadmin", username: "Andrew Mitchell", password: "password", password_confirmation: "password", email: "andrew@example.com"
		And user "Jonathon Mitchell" exists with role: "admin", username: "Jonathon Mitchell", password: "password", password_confirmation: "password", email: "jonathon@example.com"
		And user "Zoe Mitchell" exists with role: "member", username: "Zoe Mitchell", password: "password", password_confirmation: "password", email: "zoe@example.com"
		And I am logged in as "Andrew Mitchell"
		When I go to the admin user index page
		And I should not see "Andrew Mitchell" in the admin users section
		And I should not see "superadmin" in the admin users section
		And I should see "Jonathon Mitchell" in the section for user "Jonathon Mitchell"
		And I should see "admin" in the section for user "Jonathon Mitchell"
		And I should see "Zoe Mitchell" in the section for user "Zoe Mitchell"
		And I should see "member" in the section for user "Zoe Mitchell"
		When I follow "Edit" in the section for user "Jonathon Mitchell"
		Then I should be on the admin edit user page for user "Jonathon Mitchell"
		And "admin" should be selected for "Role"
	
		And I select "member" from "Role"
		And I press "Save"
		Then I should be on the admin page for user "Jonathon Mitchell"
		Then I should see "Jonathon Mitchell"
		And I should not see "admin" in the admin show user section
		And I should see "member" in the admin show user section
	
	Scenario: Changing users role without privelages
		Given user "Jonathon Mitchell" exists with role: "admin", username: "Jonathon Mitchell", password: "password", password_confirmation: "password", email: "jonathon@example.com"
		And user "Zoe Mitchell" exists with role: "member", username: "Zoe Mitchell", password: "password", password_confirmation: "password", email: "zoe@example.com"
		And I am logged in as "Jonathon Mitchell"
		When I go to the admin user index page
		Then I should see "Jonathon Mitchell" in the section for user "Jonathon Mitchell"
		And I should see "admin" in the section for user "Jonathon Mitchell"
		And I should see "Zoe Mitchell" in the section for user "Zoe Mitchell"
		And I should see "member" in the section for user "Zoe Mitchell"
		And I should not see "Edit User" in the section for user "Zoe Mitchell"
		
	Scenario: Deleting a user as super admin
		Given user "Andrew Mitchell" exists with role: "superadmin", username: "Andrew Mitchell", password: "password", password_confirmation: "password", email: "andrew@example.com"
		And user "Jonathon Mitchell" exists with role: "admin", username: "Jonathon Mitchell", password: "password", password_confirmation: "password", email: "jonathon@example.com"
		And user "Zoe Mitchell" exists with role: "member", username: "Zoe Mitchell", password: "password", password_confirmation: "password", email: "zoe@example.com"
		And I am logged in as "Andrew Mitchell"
		When I go to the admin user index page
		And I follow "Delete" in the section for user "Jonathon Mitchell"
		Then I should be on the admin user index page
		And I should not see "Jonathon Mitchell"
		When I follow "Show" in the section for user "Zoe Mitchell"
		Then I should be on the admin page for user "Zoe Mitchell"
		When I follow "Delete User"
		Then I should be on the admin user index page
		And I should not see "Zoe Mitchell"
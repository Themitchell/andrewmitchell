Feature: Pictures Index
	In order to see the most recent pictures
	As a user
	I want to see al pictures on the pictures page
	
	Scenario: No posts in blog
		Given I am on the picture index page
		Then I should see "There are currently no pictures."

	Scenario: 1 picture in blog
		Given user "Andrew Mitchell" exists with role: "admin", username: "Andrew Mitchell", password: "password", password_confirmation: "password", email: "admin@example.com"
		And picture "A picture" exists with title: "A picture", description: "picture description", picture_file_name: "picture.jpg", author: user "Andrew Mitchell", published_on: "01-01-2010", tag_list: "Apple, Ableton"
		
		When I go to the picture index page
		Then I should see "A picture"
		And I should see a "thumbnail" size image with file name "picture.jpg" and alt tag "A picture"
		And I follow "A picture"
		Then I should be on the page for picture "A picture"
		Then I should see "A picture"
		And I should see a "picture" size image with file name "picture.jpg" and alt tag "A picture"
		And I should see "picture description"
		And I should see "1 January, 2010"
		And I should see "Apple"
		And I should see "Ableton"
		
	Scenario: Pagination on the blog index
    Given the following pictures exist:
      | title      | description		 | published_on | picture_file_name |
      | picture 1  | picture desc	1  | 2010-04-20   | picture.jpg				|
      | picture 2  | picture desc 2  | 2010-04-19   | picture.jpg       |
      | picture 3  | picture desc	3  | 2010-04-18   | picture.jpg       |
      | picture 4  | picture desc 4  | 2010-04-17   | picture.jpg       |
      | picture 5  | picture desc 5  | 2010-04-16   | picture.jpg       |
			| picture 6  | picture desc	6  | 2010-04-15   | picture.jpg       |
      | picture 7  | picture desc 7  | 2010-04-14   | picture.jpg       |
      | picture 8  | picture desc	8  | 2010-04-13   | picture.jpg       |
      | picture 9  | picture desc 9  | 2010-04-12   | picture.jpg       |
      | picture 10 | picture desc 10 | 2010-04-11   | picture.jpg       |
			| picture 11 | picture desc	11 | 2010-04-10   | picture.jpg       |
      | picture 12 | picture desc 12 | 2010-04-09   | picture.jpg       |
      | picture 13 | picture desc	13 | 2010-04-08   | picture.jpg       |
      | picture 14 | picture desc 14 | 2010-04-07   | picture.jpg       |
      | picture 15 | picture desc 15 | 2010-04-06   | picture.jpg       |
			| picture 16 | picture desc	16 | 2010-04-05   | picture.jpg       |
      | picture 17 | picture desc 17 | 2010-04-04   | picture.jpg       |
      | picture 18 | picture desc	18 | 2010-04-03   | picture.jpg       |
      | picture 19 | picture desc 19 | 2010-04-02   | picture.jpg       |
      | picture 20 | picture desc 20 | 2010-04-01   | picture.jpg       |
			| picture 21 | picture desc 21 | 2010-03-01   | picture.jpg       |
    When I go to the picture index page
    Then I should see "picture 1"
    And I should see "picture 2"
    And I should see "picture 3"
    And I should see "picture 4"
    And I should see "picture 5"
		And I should see "picture 6"
    And I should see "picture 7"
    And I should see "picture 8"
    And I should see "picture 9"
    And I should see "picture 10"
		And I should see "picture 11"
    And I should see "picture 12"
    And I should see "picture 13"
    And I should see "picture 14"
    And I should see "picture 15"
		And I should see "picture 16"
    And I should see "picture 17"
    And I should see "picture 18"
    And I should see "picture 19"
    And I should see "picture 20"
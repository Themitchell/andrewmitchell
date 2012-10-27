# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

themitchell = User.create!(
  username:   'Themitchell',
  first_name: 'Andrew',
  last_name:  'Mitchell',
  email:      'themitchell@me.com',
  password:   'password',
  password_confirmation: 'password',
  role:       'admin'
) unless User.find_by_email('themitchell@me.com')

personal_statement = ContentBlock.create!(
  name: "personal statement", 
  body: "<p>I am a software developer/audio engineer based in London, Uk. I write mostly web applications" +
        " using Ruby & Rails by day.</p>" +
        "<p>I sometimes write web apps in node too using Socket.io and Express and I have a huge love for" +
        " audio engineering and music as you can see!</p>" +
        "<p>I also write, produce and mix electronic music.</p>"
) unless ContentBlock.find_by_name("personal statement")

unboxed = EmploymentHistoryItem.create!(
  company_name:     "Unboxed Consulting",
  company_role:     "Ruby / Front End Developer",
  role_description: "Developing web applications with Ruby, Ruby on Rails and Javascript. Behaviour & Test Driven Development and Agile methodolgies. On projects such Channel5.com, Reevoo.com, Agileista, Tipped and Contiki.co.uk",
  date_from:        "01/06/2010"
) unless EmploymentHistoryItem.find_by_company_name("Unboxed Consulting")

freelance = EmploymentHistoryItem.create!(
  company_name:     "Freelance PHP developer",
  company_role:     "PHP Developer",
  role_description: "Freelance development projects such as personal projects including Puzzled Records online presence and an online video portfolio for CeriAllen.com.",
  date_from:        "01/01/2010",
  date_to:          "01/06/2010"
) unless EmploymentHistoryItem.find_by_company_name("Freelance PHP Developer")

masters = EducationalQualification.create!(
  name:         'MSc Advanced Audio Production',
  institution:  'University of Glamorgan',
  grade:        'Merit',
  date_from:    '01/09/2008',
  date_to:      '01/10/2009'
) unless EducationalQualification.find_by_name("MSc Advanced Audio Production")

bachelors = EducationalQualification.create!(
  name:         'BSc Audio Engineering',
  institution:  'University of Glamorgan',
  grade:        '2:1',
  date_from:    '01/09/2005',
  date_to:      '01/06/2008'
) unless EducationalQualification.find_by_name("BSc Audio Engineering")

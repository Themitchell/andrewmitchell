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
  body: "<p>some bunch  of text here</p>"
)

unboxed = EmploymentHistoryItem.create!(
  company_name:     "Unobxed Consulting",
  company_role:     "Developer",
  role_description: "Developing web applications with Ruby, Ruby on Rails and Javascript. Behaviour & Test Driven Development and Agile methodolgies. On projects such Channel5.com, Reevoo.com, Agileista, Tipped and Contiki.co.uk",
  date_from:        "01/06/2010"
) unless EmploymentHistoryItem.find_by_company_name("Unboxed Consulting")

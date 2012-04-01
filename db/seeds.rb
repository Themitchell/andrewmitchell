# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

themitchell = User.create(
  :username => 'The Mitchell',
  :first_name => 'Andrew',
  :last_name => 'Mitchell',
  :email => 'themitchell@me.com',
  :password => 'password',
  :password_confirmation => 'password',
  :role => "admin"
) unless User.find_by_email('themitchell@me.com')

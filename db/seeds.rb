# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# This is the default administrator account, PLEASE CHANGE THE PASSWORD!
user = User.new
user.username = "admin"
user.password = "password"

user.save

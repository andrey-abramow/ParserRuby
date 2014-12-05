require 'rubygems'
require 'json'
require 'iniparse'
require 'inifile'
require 'pry'
require 'singleton'

require './lib/content-writer-factory'
require_relative 'lib/parser-factory'
require_relative 'ActiveRecord/database'


# User.new({:name => 'Vlad', :last_name => 'M'}).save
# User.new({:name => 'Andrey', :last_name => 'Abramov'}).save

# ok
# user3 = User.find(12)
# p user3.name
# p user3.id
# user3.name ="sdjhfkdshfkjsdhf"
# user3.save
# user3 = User.find(12)
# p user3.name

# ok
# user2 = User.new
# user2.name = "dddd"
# user2.save
# user3 = User.find(9)
# p user3.name

#
# user1  = User.new
# user1.name= "name1"
# user1.last_name= "lastname"
# user1.save


 # User.all[0].age #


# p JSON.parse(File.read('fixtures/user.json'))
# p documents

# todo scan all directory
 Dir.entries("./fixtures").each do|filename|
 if filename!='.' && filename!='..'
    p filename
    content = ParserFactory.create(filename).parse_content
    p content
    ContentWriterFactory.get_content_writer(filename).write_content_to_database(content)
end
   p "!!!!!!!!!!"
 # Database.open("ActiveRecord/Databases/db.db")
 # Database.execute("INSERT INTO User (name,lastname) VALUES ('andrey','abramow')")
 # p  Database.execute("SELECT * FROM User")


end


# def each(array)
#   for i in array
#     yield(i)
#   end
# end
#
# each([1,2,3]) {|n| p n}


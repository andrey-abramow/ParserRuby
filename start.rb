require 'rubygems'
require 'json'
require 'inifile'
require 'pry'
require 'singleton'
require './lib/content-writer-factory'
require './lib/parser-factory'
require './ActiveRecord/database'

# User.new({:name => 'Vlad', :last_name => 'M', :id => '4'}).save
# User.new({:name => 'Andrey', :last_name => 'Abramov'}).save
p User.all

Dir.entries("./fixtures").each do|filename|
  if filename!='.' && filename!='..'
    content = ParserFactory.create(filename).parse_content
    ContentWriterFactory.get_content_writer(filename).write_content_to_database(content)
  end
end



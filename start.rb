require 'rubygems'
require 'json'
require 'inifile'
require 'pry'
require 'singleton'
require './models/user'
require './models/post'
require './lib/parser/parser'
require './lib/parser/parser-factory'
require './lib/parser/ini-parser'
require './lib/parser/json-parser'
require './lib/content-writer'
require './active_record/database'

# User.new({:name => 'Vlad', :last_name => 'M', :id => '4'}).save
# User.new({:name => 'Andrey', :last_name => 'A'}).save
p User.all

Dir.entries("./fixtures").each do|filename|
  if filename!='.' && filename!='..'
    content = ParserFactory.create(filename).parse_content
    ContentWriter.new(filename,content).write_content_to_database
  end
end



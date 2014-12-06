require_relative 'parser'
require 'json'

class JsonParser < Parser

  def parse_content
    content =  JSON.parse(File.read("fixtures/"+@@filename))
    content
  end

end

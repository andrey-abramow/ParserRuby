require_relative 'parser'
require 'json'
class JsonParser < Parser
  def parse_content
    p "in parse content Json Parser"
    content =  JSON.parse(File.read("fixtures/"+@@filename))
    content
  end
end
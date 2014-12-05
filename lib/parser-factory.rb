require_relative 'json-parser'
require_relative 'ini-parser'
class ParserFactory

  def self.create(filename)

      if filename['.json']
        p "JsonParser.new filename"
        return JsonParser.new filename
      end
      if filename['.ini']
        p "JsonParser.new filename"
        return IniParser.new filename
      end
  end
end
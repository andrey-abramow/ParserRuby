require_relative 'json-parser'
require_relative 'ini-parser'

class ParserFactory

  def self.create(filename)
    if filename['.json']
       return JsonParser.new filename
    end
    if filename['.ini']
       return IniParser.new filename
    end
  end

end

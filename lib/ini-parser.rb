require_relative 'parser'
require 'inifile'

class IniParser < Parser

  def parse_content
     responce =  IniFile.load('fixtures/'+@@filename)
     i = 0
     result=[]
     responce.each { |val| result[i]= responce[val]; i=i+1 }
     result.uniq
  end

end

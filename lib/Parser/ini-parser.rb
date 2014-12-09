class IniParser < Parser

  def parse_content
     responce =  IniFile.load('fixtures/'+@file_name)
     result=[]
     responce.each { |val| result << responce[val]}
     result.uniq
  end

end

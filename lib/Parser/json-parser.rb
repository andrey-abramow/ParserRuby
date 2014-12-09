class JsonParser < Parser

  def parse_content
    JSON.parse(File.read("fixtures/"+@file_name))
  end

end
class ParserFactory

  def self.create(file_name)
    parser_object file_name
  end

  private

  def self.extension(file_name)
    file_name.split('.')[1].capitalize
  end

  def self.parser_class_name(file_name)
    "#{extension(file_name)}Parser"
  end

  def self.parser_object(file_name)
    Object.const_get(parser_class_name(file_name)).new file_name
  end

end

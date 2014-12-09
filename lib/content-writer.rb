class ContentWriter

  def write_content_to_database
    @content.each do  |row|
      table = get_table_info_by_id(row['id'])
      write_row(table,row)
    end
  end

  protected
  def initialize(file_name, content)
    @file_name = file_name
    @content = content
  end

  def get_table_info_by_id(id)
    table = Object.const_get(table_name).find(id)
    unless table
      table = Object.const_get(table_name).new
      table.new?(true)
    end
    table
  end

  def write_row(table,row)
    row.each {|key,value| table.send "#{key}=", value}
    table.save
  end

  private

  def table_name
    @file_name.split('.')[0].capitalize
  end

end

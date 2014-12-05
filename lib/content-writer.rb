class ContentWriter

  def write_content_to_database(content)
    content.each do  |row|
      table = get_table_info_by_id(row['id'])
      write_row(table,row)
    end
  end

  protected
  def get_table_info_by_id(id)

  end

  def write_row(table,row)

  end
end
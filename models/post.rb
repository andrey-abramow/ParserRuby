require './active_record/database-table'

class Post < DatabaseTable

  database_fields :name, :text, :id

end

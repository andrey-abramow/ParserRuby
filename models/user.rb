require './active_record/database-table'

class User < DatabaseTable

  database_fields :name, :last_name, :age, :id

end

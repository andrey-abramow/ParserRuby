require_relative '../ActiveRecord/database-table'

class Post < DatabaseTable
 database_fields :name, :last_name, :age, :id
end
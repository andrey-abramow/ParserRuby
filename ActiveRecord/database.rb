require "sqlite3"

class Database
  include ::Singleton

  FILE_NAME = 'ActiveRecord/Databases/db.db'

  def execute(*args)
    @db.execute(*args)
  end

  def last_insert_row_id
    @db.last_insert_row_id
  end

  protected
  def initialize
    @db = SQLite3::Database.new FILE_NAME
    _configure
    _create_database
   end

  def _configure
    @db.results_as_hash = true
    @db.type_translation = true
  end

  def _create_database
    @db.execute "CREATE TABLE IF NOT EXISTS User(id INTEGER PRIMARY KEY   AUTOINCREMENT, name TEXT, last_name TEXT, age TEXT)"
    @db.execute "CREATE TABLE IF NOT EXISTS Post(id INTEGER PRIMARY KEY   AUTOINCREMENT, name TEXT, text TEXT)"
   end

end

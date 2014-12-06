require_relative '../ActiveRecord/database-table'

class Post < DatabaseTable

  def initialize(params={})
    self.class.database_fields :name, :text, :id
    super(params)
  end

end

require_relative '../ActiveRecord/database-table'

class User < DatabaseTable

  def initialize(params={})
    self.class.database_fields :name, :last_name, :age, :id
    super(params)
  end

end

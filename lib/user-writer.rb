require_relative 'content-writer'
require_relative '../Tables/user'
class UserWriter < ContentWriter

  protected
  def get_table_info_by_id(id)
    user = User.find(id)
    if not user
      user = User.new
      user.new?(true)
    end
    return user
  end

  def write_row(user,row)
    user.name= row['name']
    user.last_name= row['last_name']
    user.id= row['id']
    user.age= row['age']
    user.save
  end

end
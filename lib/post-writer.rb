require_relative 'content-writer'
require_relative '../Tables/post'
class PostWriter < ContentWriter
  protected
  def get_table_info_by_id(id)
    post = Post.find(id)
    unless post
      post = Post.new
      post.new?(true)
    end
    return post
  end

  def write_row(post,row)
    post.id= row['id']
    post.name= row['name']
    post.text= row['text']
    post.save
  end
end
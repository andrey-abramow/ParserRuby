require_relative 'user-writer'
require_relative 'post-writer'

class ContentWriterFactory

  def self.get_content_writer(filename)
    if filename['user']
     return UserWriter.new
    end
    if filename['post']
     return  PostWriter.new
    end

  end
end
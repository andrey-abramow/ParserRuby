require_relative 'database'

class DatabaseTable

  def self.database_fields(*fields)
    attr_accessor *fields
    @@fields = nil
    @@fields = fields
  end

  def self.table_name
    self.name
  end

  def new?(bool)
    @new = bool
  end

  def self.find(id)
    @db = Database.instance
    row = @db.execute("SELECT * FROM " + table_name + " WHERE id = ?", id)
    row.length == 0 ? nil : self.new(row[0])
  end

  def self.all
    @db = Database.instance
    row = @db.execute("SELECT * FROM " + table_name)
    return row
  end

  def values
    values =[]
    i = 0
    @@fields.each { |field| values[i] = self.send(field.to_s); i=i+1}
    values
  end

  def inserted?
    self.id and not @new ? true:false
  end

  def save
    inserted? ? update : create
  end

  protected
  def initialize(params={})
    params.each { |field, value| self.send "#{field}=", value}
  end

  private
  def create
    @values = values
    @fields =[]
    i = 0
    @@fields.each do |field|
      if self.send(field.to_s)
        @fields[i] = field
        i = i+1
      end
    end
    @db = Database.instance
    val_query =''
    @values= @values.compact
    @values.each {|| val_query = val_query + '?,'}
    val_query = val_query[0.. -2]
    @db.execute('INSERT INTO ' + self.class.table_name + '( ' + @fields.join(', ') + ') VALUES ('+val_query + ')', @values)
  end

  def update
    val_query=''
    @@fields.each do |field|
       if self.send(field)!=nil
         val_query = val_query + field.to_s + ' = ' + "'" + self.send(field.to_s).to_s + "'" + ','
       end
    end
    val_query = val_query[0.. -2]
    @db = Database.instance
    @db.execute('UPDATE  '+ self.class.table_name + ' SET ' + val_query + 'WHERE id = ' + self.send('id').to_s)
  end

end

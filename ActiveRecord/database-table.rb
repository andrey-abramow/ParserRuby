require_relative 'database'
class DatabaseTable

  @new = false

  def self.database_fields(*fields)
    attr_accessor *fields
    @@fields = fields
    p 'fields!!!!!'
    p @@fields
  end

  def self.table_name
    self.name
  end

  def new?(bool)
    @new = bool
  end

  def self.find(id)
    @db = Database.instance
    # sql = "SELECT * FROM " + table_name + " WHERE id = ?"
    row = @db.execute("SELECT * FROM " + table_name + " WHERE id = ?", id)
    # p "in find before row "
    # p row
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
    @@fields.each do |field|
      values[i] = self.send(field.to_s)
      i=i+1
    end
    p values
    values
  end

  def inserted?
    # ok

    !@new && self.id ? true:false
  end

  def save
    # ok
    inserted? ? update : create
  end

  protected
  def initialize(params = {})
    # ok
    # p params
    if params!={} #rm_todo check
      params.each do |field, value|
        # p  "#{field}="
        # p value
        self.send "#{field}=", value
        # self.send("#{field.to_s}=", value)
      end
    end
  end

  private
  def create
    @values = values
    @db = Database.instance
    val_query =''
    @values.each {|| val_query = val_query + '?,' }
    val_query = val_query[0.. -2]
    # p @values
    sql = 'INSERT INTO ' + self.class.table_name + '( ' + @@fields.join(', ') + ') VALUES ('+val_query + ')', @values
    rows = @db.execute('INSERT INTO ' + self.class.table_name + '( ' + @@fields.join(', ') + ') VALUES ('+val_query + ')', @values)
    p sql
   end

  def update
    set ={}
    @@fields.each do |field|
       set[field]= self.send(field)
    end
    val_query=''
    @@fields.each do |field|
       if self.send(field)!=nil
         val_query = val_query + field.to_s + ' = ' + "'" + self.send(field.to_s) + "'" + ','
       end
    end
    val_query = val_query[0.. -2]
    p val_query
    # p set
    sql = 'UPDATE  '+ self.class.table_name + ' SET ' + val_query + 'WHERE id = ' + self.send('id').to_s
    p sql
    p self.send('id').to_s
    @db = Database.instance
    row = @db.execute('UPDATE  '+ self.class.table_name + ' SET ' + val_query + 'WHERE id = ' + self.send('id').to_s  )
  end

end
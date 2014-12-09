require './active_record/database'

class DatabaseTable

  class << self

    def fields=(fields)
      @fields = fields
    end

    def fields
      @fields
    end

    def database_fields(*fields)
      attr_accessor *fields
      self.fields = fields
    end

    def table_name
      name
    end

    def find(id)
      row = Database.instance.execute("SELECT * FROM  #{table_name} WHERE id = ?", id)
      row.length == 0 ? nil : self.new(row[0])
    end

    def all
      Database.instance.execute("SELECT * FROM #{table_name}")
    end

  end

  public

  def new?(bool)
    @new = bool
  end

  def values
    self.class.fields.map { |field|
      self.send(field.to_s)
    }
  end

  def inserted?
    self.id and not @new
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
    fields = []
    self.class.fields.each do |field|
      fields << field if self.send(field.to_s)
    end
    @values = @values.compact
    val_query = (['?'] * @values.length).join(',')
    Database.instance.execute(["INSERT INTO  #{self.class.table_name} (  #{fields.join(', ')} ) ",
                               "VALUES ( #{val_query})"].join(' '), @values)
  end

  def update
    setters = []
    values = []
    self.class.fields.each do |field|
      setters << "#{field.to_s} = ?" if self.send(field)
      values << self.send(field) if self.send(field)
      # todo place holder
    end
    Database.instance.execute(["UPDATE #{self.class.table_name}",
                               "SET #{setters.join(',')}",
                               "WHERE id = ?"].join(' '), values, id.to_s)
  end

end

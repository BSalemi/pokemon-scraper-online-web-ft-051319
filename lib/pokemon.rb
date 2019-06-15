class Pokemon
  attr_accessor :name, :type
  attr_reader :id, :db


  def initialize(id:, name:, type:, db:, hp = 60)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db, hp)
    sql = <<-SQL
    INSERT INTO pokemon(name, type) VALUES(?,?)
    SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
    SELECT * FROM pokemon
    WHERE id = ?
    SQL
    pokemon = db.execute(sql, id)
    id = pokemon[0][0]
    name = pokemon[0][1]
    type = pokemon[0][2]
    new_pokemon = Pokemon.new(id: id, name: name, type: type, db: db)
    # binding.pry
    new_pokemon
  end
end

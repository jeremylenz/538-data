class State

  def self.create_table

    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS states (
        id INTEGER PRIMARY KEY,
        state TEXT,
        abbrev TEXT
      );
    SQL

    DB[:conn].execute(sql)

  end

  def self.insert_values(row)
    sql = <<-SQL
    INSERT INTO states (state)
    VALUES (?);
    SQL

    DB[:conn].execute(sql, row)

  end

  def self.insert_all_values(data)

    data.each do |row|
      self.insert_values(row[0])
    end
  end

  def self.drop_table

    sql = <<-SQL
    DROP TABLE IF EXISTS states;
    SQL

    DB[:conn].execute(sql)

  end

  def self.find_id_by_name(name)
    sql = <<-SQL
    SELECT id FROM states
    WHERE state = ?;
    SQL

    DB[:conn].execute(sql,name)

  end


end

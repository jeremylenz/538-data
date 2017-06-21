class State

  attr_reader :name

  def initialize(state_name)
    @name = state_name

  end

  def self.find_or_create_by(name)
    if !self.find_id('state', name).empty? || !self.find_id('abbrev', name).empty?
      self.new(name)
    end

  end

  def self.all
    sql = "SELECT * FROM states;"
    DB[:conn].execute(sql)

  end

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

  def self.insert_abbreviation(row)
    sql = <<-SQL
    UPDATE states
    SET abbrev = ?
    WHERE state = ?;
    SQL

    DB[:conn].execute(sql, row[1],row[0])

  end

  def self.insert_all_abbrevs(data)
    data.each do |row|
      self.insert_abbreviation(row)
    end
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

  def self.find_id(col_name, state)  
    return nil if !["abbrev", "state"].include?(col_name)
    query = <<-SQL
    SELECT id FROM states
    WHERE #{col_name} = ?;
    SQL
    DB[:conn].execute(query, state)
  end

  def self.insurance_premiums
    sql = <<-SQL
    SELECT states.state, insurance_data.premiums
    FROM insurance_data
    JOIN states
    ON states.id = insurance_data.state_id
    SQL

    DB[:conn].execute(sql)
  end

  def insurance_premium
    state_id = self.class.find_id_by_name(self.name)[0][0]

    sql = <<-SQL
    SELECT premiums FROM insurance_data
    WHERE state_id=?
    SQL

    DB[:conn].execute(sql,state_id)[0][0]

  end

  def self.fatal_duis # Returns the number of fatal DUIs per billion miles driven
    sql = <<-SQL
    SELECT states.state, ROUND(bad_drivers_data_by_state.dfc_dui * bad_drivers_data_by_state.dfc_per_bil_miles / 100, 2)
    FROM bad_drivers_data_by_state
    JOIN states ON states.id = bad_drivers_data_by_state.state_id
    SQL

    DB[:conn].execute(sql)

  end

  def fatal_duis
    state_id = self.class.find_id_by_name(self.name)[0][0]

    sql = <<-SQL
    SELECT ROUND(dfc_dui * dfc_per_bil_miles / 100,2)
    FROM bad_drivers_data_by_state
    WHERE state_id=?
    SQL

    DB[:conn].execute(sql, state_id)[0][0]

  end


end

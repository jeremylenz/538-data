class State

  attr_reader :name

  def initialize(state_name)
    @name = state_name

  end

  def self.extract_data(data)
    data.each_with_object([]) do |row, arr|
      arr << row[0..1]
    end
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
    SELECT states.state, ROUND(drivers.dfc_dui * drivers.dfc_per_bil_miles / 100, 2)
    FROM drivers
    JOIN states ON states.id = drivers.state_id
    SQL

    DB[:conn].execute(sql)

  end

  def fatal_duis
    state_id = self.class.find_id_by_name(self.name)[0][0]

    sql = <<-SQL
    SELECT ROUND(dfc_dui * dfc_per_bil_miles / 100,2)
    FROM drivers
    WHERE state_id=?
    SQL

    DB[:conn].execute(sql, state_id)[0][0]

  end


end

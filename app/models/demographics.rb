class Demographic
  def self.create_table

    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS demographics (
        id INTEGER PRIMARY KEY,
        state_id INTEGER,
        hh_income INTEGER,
        unemployment REAL
      );
    SQL

    DB[:conn].execute(sql)

  end

  def self.insert_values(row)
    sql = <<-SQL
    INSERT INTO demographics (state_id,hh_income,unemployment)
    VALUES (?,?,?);
    SQL

    row[0] = State.find_id_by_name(row[0])
    DB[:conn].execute(sql, row)

  end

  def self.insert_all_values(data)

    data.each do |row|
      self.insert_values(row[0..2])
    end
  end

  def self.drop_table

    sql = <<-SQL
    DROP TABLE IF EXISTS demographics;
    SQL

    DB[:conn].execute(sql)

  end


end

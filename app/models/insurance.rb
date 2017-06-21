class Insurance



  def self.cols_to_extract
    [0,-2,-1]
  end

  def self.create_table

    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS insurance_data (
        id INTEGER PRIMARY KEY,
        state_id INTEGER,
        premiums REAL,
        losses REAL
      );
    SQL

    DB[:conn].execute(sql)

  end

  def self.insert_values(row)
    row[0] = State.find_id_by_name(row[0])

    sql = <<-SQL
    INSERT INTO insurance_data (state_id, premiums, losses)
    VALUES (?, ?, ?);
    SQL

    DB[:conn].execute(sql, row[0], row[-2], row[-1])

  end

  def self.insert_all_values(data)

    data.each do |row|
      self.insert_values(row)
    end
  end

  def self.drop_table

    sql = <<-SQL
    DROP TABLE IF EXISTS insurance_data;
    SQL

    DB[:conn].execute(sql)

  end


end

class Driver

  def self.create_table

    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS bad_drivers_data_by_state (
        id INTEGER PRIMARY KEY,
        state_id INTEGER,
        dfc_per_bil_miles REAL,
        dfc_speeding INTEGER,
        dfc_dui INTEGER,
        dfc_aware INTEGER,
        dfc_first_timers INTEGER

      );
    SQL

    DB[:conn].execute(sql)

  end



  def self.insert_values(row)
    sql = <<-SQL
    INSERT INTO bad_drivers_data_by_state (state_id, dfc_per_bil_miles, dfc_speeding, dfc_dui, dfc_aware, dfc_first_timers)
    VALUES (?, ?, ?, ?, ?, ?);
    SQL

    row[0] = State.find_id_by_name(row[0])

    DB[:conn].execute(sql, row)

  end

  def self.insert_all_values(data)

    data.each do |row|
      self.insert_values(row[0..-3])
    end

  end

  def self.drop_table

    sql = <<-SQL
    DROP TABLE IF EXISTS bad_drivers_data_by_state;
    SQL

    DB[:conn].execute(sql)

  end



  end

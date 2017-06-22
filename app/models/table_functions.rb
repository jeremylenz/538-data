class TableFunctions

  def self.create_all_tables
    Data.tables.each do |table_name,columns|
      self.create(table_name,columns)
    end
  end

  def self.drop_all_tables
    Data.tables.keys.each do |table_name|
      self.drop(table_name)
    end
  end

  def self.create(table_name, args) # args is a hash where keys are col_names, values are datatypes.
    sql = "CREATE TABLE IF NOT EXISTS #{table_name} \n(id INTEGER PRIMARY KEY"
    args.each do |arg|
      sql << ",\n#{arg[0].to_s} #{arg[1]}"
    end
    sql << ");"
    # binding.pry
    DB[:conn].execute(sql)

  end

  def self.view(table_name)
    output = DB[:conn].execute2("SELECT * FROM #{table_name}")
    output.each { |e| puts e.inspect }
  end

  def self.drop(table_name)
    sql = "DROP TABLE IF EXISTS #{table_name}"
    DB[:conn].execute(sql)
  end

  def self.all
    sql = "SELECT tbl_name FROM sqlite_master WHERE type = 'table';"
    DB[:conn].execute(sql).flatten
  end

  def self.column_names(table_name)
    sql = "SELECT * FROM #{table_name}"
    DB[:conn].execute2(sql)[0]
  end

  def self.all_column_names
    self.all.each_with_object([]) do |table, arr|
      arr << self.column_names(table)
    end.flatten.uniq
  end

  def self.insert_into(table_name, column_names, vals) # args: key is column name, value is value
    sql = "INSERT INTO #{table_name}\n("
    sql << column_names.map(&:to_s).join(", ")
    sql << ")\nVALUES (#{vals.map { |val| '?' }.join(', ')});"
    DB[:conn].execute(sql, vals)

  end

  def self.insert_all_values(table_name, column_names, data)

    data.each do |row|
      self.insert_into(table_name, column_names, row)
    end
  end

  def self.add_column(table_name, col_info) #col_info is a hash, key is col_name, value is datatype
    sql = <<-SQL
    ALTER TABLE #{table_name}
    ADD #{col_info.keys[0].to_s} #{col_info.values[0]}
    SQL
    DB[:conn].execute(sql)

  end

  def self.extract_data(table_name,data)
    case table_name
    when 'drivers'
      Driver.extract_data(data)
    when 'insurance_data'
      Insurance.extract_data(data)
    when 'demographics'
      Demographic.extract_data(data)
    when 'states'
      State.extract_data(data)
    end
  end


end

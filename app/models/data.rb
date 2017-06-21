class Data
  def self.get_csv_data(filename)
    data = File.read(filename)
    CSV.parse(data)
  end

  def self.data_source(table_name)
    case table_name
    when "drivers", "insurance_data"
      '../bad-drivers.csv'
    when "states"
      '../states.csv'
    when "demographics"
      '../hate_crimes.csv'
    end

  end
end

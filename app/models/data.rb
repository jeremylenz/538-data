class Data
  def self.get_csv_data(filename)
    data = File.read(filename)
    CSV.parse(data)
  end
end

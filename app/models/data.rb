class Data
  def self.get_csv_data
    data = File.read('../bad-drivers.csv')
    CSV.parse(data)
  end
end

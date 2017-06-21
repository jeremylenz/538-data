class Insurance


  def self.extract_data(data)
    data.each_with_object([]) do |row, arr|
      row[0] = State.find_id_by_name(row[0])
      arr << row[-2..-1].unshift(row[0])
    end
  end


end

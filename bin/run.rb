require_relative '../config/environment.rb'


TableFunctions.drop_all_tables
TableFunctions.create_all_tables

TableFunctions.all.each do |table_name|
  data = Data.get_csv_data(Data.data_source(table_name)).drop(1)
  TableFunctions.insert_all_values(table_name, TableFunctions.column_names(table_name).drop(1), TableFunctions.extract_data(table_name,data))
end

# State.insert_all_values(data)

binding.pry

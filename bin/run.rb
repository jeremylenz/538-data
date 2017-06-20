require_relative '../config/environment.rb'
State.drop_table
State.create_table

Driver.drop_table
Driver.create_table

Insurance.drop_table
Insurance.create_table

Demographic.drop_table
Demographic.create_table

data = Data.get_csv_data('../bad-drivers.csv').drop(1)
# binding.pry
State.insert_all_values(data)
Driver.insert_all_values(data)
Insurance.insert_all_values(data)

data = Data.get_csv_data('../hate_crimes.csv').drop(1)
Demographic.insert_all_values(data)

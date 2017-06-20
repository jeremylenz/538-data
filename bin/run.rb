require_relative '../config/environment.rb'
State.drop_table
State.create_table

Driver.drop_table
Driver.create_table

Insurance.drop_table
Insurance.create_table

data = Data.get_csv_data.drop(1)
# binding.pry


State.insert_all_values(data)
Driver.insert_all_values(data)
Insurance.insert_all_values(data)

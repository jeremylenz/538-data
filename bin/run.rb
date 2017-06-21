require_relative '../config/environment.rb'

# State.drop_table
# State.create_table

TableFunctions.drop('states')
TableFunctions.create('states',{state: 'TEXT', abbrev: 'TEXT'})

TableFunctions.drop('drivers')
TableFunctions.drop('bad_drivers_data_by_state')
TableFunctions.create('drivers',{state_id: 'INTEGER', dfc_per_bil_miles: 'REAL', dfc_speeding: 'INTEGER', dfc_dui: 'INTEGER', dfc_aware: 'INTEGER', dfc_first_timers: 'INTEGER'})

TableFunctions.drop('insurance_data')
TableFunctions.create('insurance_data',{state_id: 'INTEGER', premiums: 'REAL', losses: 'REAL'})

#
# Demographic.drop_table
# Demographic.create_table
TableFunctions.drop('demographics')
TableFunctions.create('demographics', {state_id: 'INTEGER', hh_income: 'INTEGER', unemployment: 'REAL'})


data = Data.get_csv_data('../bad-drivers.csv').drop(1)

data = Driver.extract_data(data)

TableFunctions.all.each do |table_name|
  TableFunctions.insert_all_values(table_name, TableFunctions.column_names(table_name), TableFunctions.extract_data(table_name))
end

# State.insert_all_values(data)
TableFunctions.insert_all_values('drivers', TableFunctions.column_names('drivers'), TableFunctions.extract_data('drivers'))

Driver.insert_all_values(data)
Insurance.insert_all_values(data)

data = Data.get_csv_data('../states.csv').drop(1)
State.insert_all_abbrevs(data)


data = Data.get_csv_data('../hate_crimes.csv').drop(1)
Demographic.insert_all_values(data)

binding.pry

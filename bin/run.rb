require_relative '../config/environment.rb'

# State.drop_table
# State.create_table

TableFunctions.drop('states')
TableFunctions.create('states',{state: 'TEXT', abbrev: 'TEXT'})

TableFunctions.drop('drivers')
TableFunctions.create('drivers',{state_id: 'INTEGER', dfc_per_bil_miles: 'REAL', dfc_speeding: 'INTEGER', dfc_dui: 'INTEGER', dfc_aware: 'INTEGER', dfc_first_timers: 'INTEGER'})

TableFunctions.drop('insurance_data')
TableFunctions.create('insurance_data',{state_id: 'INTEGER', premiums: 'REAL', losses: 'REAL'})

#
# Demographic.drop_table
# Demographic.create_table
TableFunctions.drop('demographics')
TableFunctions.create('demographics', {state_id: 'INTEGER', hh_income: 'INTEGER', unemployment: 'REAL'})


TableFunctions.all.each do |table_name|
  data = Data.get_csv_data(Data.data_source(table_name)).drop(1)
  TableFunctions.insert_all_values(table_name, TableFunctions.column_names(table_name).drop(1), TableFunctions.extract_data(table_name,data))
end

# State.insert_all_values(data)

binding.pry

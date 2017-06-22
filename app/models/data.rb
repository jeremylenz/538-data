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

  def self.tables
    {'states' => {state: 'TEXT', abbrev: 'TEXT'},
    'drivers' => {state_id: 'INTEGER', dfc_per_bil_miles: 'REAL', dfc_speeding: 'INTEGER', dfc_dui: 'INTEGER', dfc_aware: 'INTEGER', dfc_first_timers: 'INTEGER'},
    'insurance_data' => {state_id: 'INTEGER', premiums: 'REAL', losses: 'REAL'},
    'demographics' => {state_id: 'INTEGER', hh_income: 'INTEGER', unemployment: 'REAL'}
    }
  end
end

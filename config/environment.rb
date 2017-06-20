require 'bundler'
Bundler.require

require 'sqlite3'
require 'pry'
require 'csv'
require 'json'


require_all '../app'

DB = {conn: SQLite3::Database.new("../db/bad-drivers.db")}

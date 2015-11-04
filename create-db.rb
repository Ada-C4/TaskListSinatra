require "./lib/database"

db = Tasklist::Database.new("taskbase.db")
db.create_schema

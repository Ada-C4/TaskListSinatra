require "./lib/database"

db = TaskList::Database.new("taskbase.db")
db.create_schema

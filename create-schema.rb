require "./lib/database.rb"

db = TaskList::Database.new("tasks.db")
db.create_schema

require "./lib/database.rb"

db = TaskList.new("tasks.db")
db.create_schema

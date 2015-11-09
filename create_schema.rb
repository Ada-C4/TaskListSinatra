require "./lib/database.rb"

db = TaskList::Database.new("task-list.db")
db.create_schema

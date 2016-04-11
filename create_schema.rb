require "./lib/database"

db = TaskList::Database.new("allofthetasks.db")
db.create_schema

require "./lib/database"

db = TaskList::Database.new("tasklist.db")
db.create_schema

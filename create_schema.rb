require "./lib/database"

db = TaskList.new("tasklist.db")
db.create_schema

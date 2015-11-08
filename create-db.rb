require "./lib/database"

db = TaskList::TaskManager.new("taskbase.db")
db.create_schema

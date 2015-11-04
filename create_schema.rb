require "./lib/database"

db = TaskList::Database.new("todo_list.db")
db.create_schema

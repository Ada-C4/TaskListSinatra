require './lib/database'

db = TaskList::Database.new("tasks.db")
db.create_schema

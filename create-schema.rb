require "./lib/database"

db = Tasklist::Database.new("tasklist.db")
db.create_schema

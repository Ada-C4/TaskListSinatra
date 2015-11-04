require "sqlite3"

module TaskList
  class Database

    def initialize(db_name)
      @db = SQLite3::Database.new(db_name)
    end

    def create_schema
      # Put your ruby code here to use the @db variable
      # to setup your schema in the databas.
      @db.execute ('
      CREATE TABLE dogs (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NULL,
        comp_date TEXT NULL
      );')
    end
  end
end

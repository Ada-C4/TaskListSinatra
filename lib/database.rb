require "sqlite3"

module TaskList
  class Database

    def initialize(db_name)
      @db = SQLite3::Database.new(db_name)
    end

    def create_schema
      # Put your ruby code here to use the @db variable
      # to setup your schema in the databas.
      @db.execute('
      CREATE TABLE tasks (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      description TEXT NULL,
      completed_date TEXT NULL
      );')
    end

    def create_tasks(name, description)
      @db.execute('
      INSERT INTO tasks (name, description)
      VALUES(?, ?)
      ;', name, description)
    end


    def get_tasks
      @db.execute('
      SELECT name, description
      FROM tasks;')
    end

    def complete_tasks(completed_date)
      @db.execute('
      UPDATE tasks(completed_date)
      VALUES(?)
      WHERE id = ?
      ;', completed_date, id)
    end

  end
end

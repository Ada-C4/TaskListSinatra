require "sqlite3"

module TaskList
  class Database

    def initialize(db_name)
      @db = SQLite3::Database.new(db_name)
    end

    def create_schema
      @db.execute('
      CREATE TABLE tasks (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      description TEXT NULL,
      completed_date TEXT NULL
      )')
    end

    def create_task(name, description = nil)
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

    def delete_single_task(name)
      @db.execute('
      DELETE FROM tasks
      WHERE name = ?;
      ', name)
    end

    def delete_tasks
      @db.execute('
      DELETE FROM tasks;
      ')
    end

  end
end

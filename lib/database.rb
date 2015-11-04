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
      completed TEXT NULL
      );')
    end

    def create_task(task_name, task_descr, task_comp)
      @db.execute('
      INSERT INTO tasks (name, description, completed)
      VALUES(?, ?, ?)
      );' task_name, task_descr, task_comp)

    end

  end
end

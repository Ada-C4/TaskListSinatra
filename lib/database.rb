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
      );')
    end

    def create_task(task_name, task_descr, task_date)
      @db.execute('
      INSERT INTO tasks (name, description, completed_date)
      VALUES(?, ?, ?)
      ;', task_name, task_descr, task_date)
    end

    def get_tasks
      @db.execute('
      SELECT name, description, completed_date
      FROM tasks;')
    end
  end
end

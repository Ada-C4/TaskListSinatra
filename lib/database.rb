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

    def create_task(task_name, task_descr)
      @db.execute('
      INSERT INTO tasks (name, description)
      VALUES(?, ?)
      ;', task_name, task_descr)
    end

    def get_tasks
      @db.execute('
      SELECT id, name, description, completed
      FROM tasks;')
    end

    def add_completion(checkbox_id)
      @db.execute('
      UPDATE tasks SET completed="dunzo" WHERE id=(?)
      ;', checkbox_id)
    end

  end
end

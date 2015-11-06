require "sqlite3"
require "pry"

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

    def get_task(id)
      task = @db.execute('
      SELECT name, description, id, completed_date
      FROM tasks
      WHERE id = ?
      ;', id)
      return task[0]
    end

    def get_tasks
      @db.execute('
      SELECT name, description, id, completed_date
      FROM tasks;')
    end

    def complete_tasks(completed_date, id)
      @db.execute('
      UPDATE tasks
      SET completed_date = ?
      WHERE id = ?
      ;', completed_date, id)
    end

    def delete_tasks(id)
      @db.execute('
      DELETE FROM tasks
      WHERE id = ?
      ;', id)
    end

    def edit_tasks(name, description, id)
      @db.execute('
      UPDATE tasks
      SET name = ?, description = ?
      WHERE id = ?
      ;', name, description, id)
    end
  end
end

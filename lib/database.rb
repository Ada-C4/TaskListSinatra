require "sqlite3"
require "pry"

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
  end

  class TaskManager < Database

    def new_task(task_name, task_description, completed_date)
      @db.execute('
        INSERT INTO tasks (name, description, completed_date) VALUES (?, ?, ?);
      ', task_name, task_description, completed_date)
    end

    #right now this selects all of the tasks
    def select_tasks
      @db.execute('
        SELECT id, name, description, completed_date
        FROM tasks;')
    end

    def completed_tasks(task_id)
       d = Time.now.strftime("%m/%d/%Y")
       @db.execute("
       UPDATE tasks SET completed_date='#{d}' WHERE id=?;
       ", task_id)
    end

    def delete_tasks(task_id)
      @db.execute("
      DELETE FROM tasks WHERE id=?;
      ", task_id)
    end

  end
end

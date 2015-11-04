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
  end

  class TaskManager < Database
    def new_task(task_name, task_description, completed_date)
      @db.execute('
        INSERT INTO tasks (name, nil, nil) VALUES (?, ?, ?);
      ', task_name, task_description, completed_date)    
    end
  end
end

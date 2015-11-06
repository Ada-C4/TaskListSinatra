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
      INSERT INTO tasks (name, description)
      VALUES(?, ?)
      ;', task_name, task_descr)
    end

    def get_tasks
      @db.execute('
      SELECT name, description, completed_date
      FROM tasks;')
    end

    def update_tasks(tasks_to_update)
      completed_date=Time.now.to_s
      tasks_to_update.each do |task_name|
        @db.execute('
        UPDATE tasks SET completed_date=?
        WHERE name=?;
        ', completed_date, task_name)
      end
    end

    def get_completed_tasks
      @db.execute('
      SELECT name, completed_date
      FROM tasks WHERE completed_date IS NOT NULL
      OR completed_date !="";')
    end


  end
end

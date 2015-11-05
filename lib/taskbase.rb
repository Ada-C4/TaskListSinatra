require "sqlite3"
require "./lib/database"

module TaskList
  class TaskBase < TaskList::Database

    def create_task(name, description, date_completed)
      @db.execute('
      INSERT INTO tasks (name, description, date_completed)
      VALUES (?,?,?)
      ;', name, description, date_completed)
    end

    def get_tasks
      @db.execute('
      SELECT * FROM tasks;
      ')
    end

  end
end

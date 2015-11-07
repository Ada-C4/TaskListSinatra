# require "sqlite3"
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

    def delete_task(id)
      @db.execute('
      DELETE FROM tasks WHERE id = ?;
      ', id)
    end

    def get_single_task(id)
      @db.execute('
      SELECT * FROM tasks WHERE id = ?;
      ', id)
    end

    def edit_task(id, name, description, date_completed)
      @db.execute('
      UPDATE tasks SET name = ?, description = ?, date_completed = ? WHERE id = ?;
      ', name, description, date_completed, id)
    end

  end
end

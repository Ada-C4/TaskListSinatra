require_relative "db_driver"

module TaskList
  class Database

    def initialize(db_name)
      @db = DBDriver.new(db_name)
    end

    def delete_schema
      @db.delete_schema
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
      SELECT id, name, description, completed_date
      FROM tasks;')
    end

    def delete_single_task(id)
      @db.execute('
      DELETE FROM tasks
      WHERE id = ?;
      ', id)
    end

    def delete_tasks
      @db.execute('
      DELETE FROM tasks;
      ')
    end

    def completed_task(task_id)
      date = Time.now.strftime("%d/%m/%Y %H:%M")
      @db.execute('
      UPDATE tasks SET completed_date = ?
      WHERE id = ?;', date, task_id)
    end

    def update_task(task_id, new_name, new_description)
      @db.execute('
      UPDATE tasks SET name = ?, description = ? WHERE id = ?;
      ',new_name, new_description, task_id)
    end

    def return_task_info(task_id)
      @db.execute('
      SELECT name, description FROM tasks WHERE id = ?;
      ',task_id)
    end
  end
end

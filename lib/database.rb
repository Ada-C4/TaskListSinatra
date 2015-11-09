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

    def get_name(checkbox_id)
      @db.execute('
      SELECT name FROM tasks WHERE id=(?)
      ;', checkbox_id)
    end

    def get_descr(checkbox_id)
      @db.execute('
      SELECT description FROM tasks WHERE id=(?)
      ;', checkbox_id)
    end

    def add_completion(checkbox_id)
      @db.execute('
      UPDATE tasks SET completed=(?) WHERE id=(?)
      ;', Time.now.strftime("%b-%d-%Y").to_s, checkbox_id)
    end

    def delete_task(checkbox_id)
      @db.execute('
      DELETE FROM tasks WHERE id=(?)
      ;', checkbox_id)
    end

    def update_task(name, descr, checkbox_id)
      @db.execute('
      UPDATE tasks SET name=(?), description=(?) WHERE id=(?)
      ;', name, descr, checkbox_id)
    end
  end
end

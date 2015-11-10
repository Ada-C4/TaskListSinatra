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
      @db.execute ('
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NULL,
        comp_date TEXT NULL
      );')
    end

    def create_task(task, descr)
      @db.execute('
      INSERT INTO tasks (name, description)
      VALUES(?, ?)
      ;', task, descr)
    end

    def get_current_tasks
      @db.execute('
      SELECT name, description, id, comp_date
      FROM tasks
      WHERE comp_date is NULL;
      ')
    end

    def get_completed_tasks
      @db.execute('
      SELECT name, description, id, comp_date
      FROM tasks
      WHERE comp_date IS NOT NULL;
      ')
    end

    def return_date(id)
      @db.execute('
      SELECT comp_date
      FROM tasks
      WHERE id= ?;
      ',id)
    end

    def complete_task(id)
      if return_date(id) == [[nil]]
        date = Time.now.strftime("%m/%d/%Y")
        @db.execute('
        UPDATE tasks SET comp_date=
        ?
        WHERE id= ?
        ;', date, id)
      end
    end

    def delete_task(id)
      @db.execute('
      DELETE FROM tasks
      WHERE id= ?
      ;', id)
    end

    def edit_task(id, name, description)
      @db.execute('
      UPDATE tasks
      SET name = ?, description = ?
      WHERE id= ?
      ;', name,description,id)
    end
  end
end

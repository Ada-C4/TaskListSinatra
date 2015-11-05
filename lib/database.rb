require "sqlite3"

module TaskList
  class Database

    def initialize(db_name)
      @db = SQLite3::Database.new(db_name)
    end

    def create_schema
      # Put your ruby code here to use the @db variable
      # to setup your schema in the databas.
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

    def get_tasks
      @db.execute('
      SELECT name, description, id, comp_date
      FROM tasks;
      ')
    end

    def complete_task(id)
      @db.execute('
      UPDATE tasks SET comp_date=
      "2015-11-05"
      WHERE id="1"
      ;')
    end

  end
end

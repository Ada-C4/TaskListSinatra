require "./lib/database"

module TaskList
  class UseDatabase < Database

    def add_task(task_name, task_description=nil, completed_task_date=nil)
      @db.execute('
      INSERT INTO tasks_table (name, description, completed_date)
      VALUES(?, ?, ?);
      ', task_name, task_description, completed_task_date)
    end

    def get_tasks
      @db.execute('
      SELECT name, description, completed_date FROM tasks_table;
      ')
    end

    def complete_tasks(task_name)
      completed_task_date = Time.now
      @db.execute('
      UPDATE tasks_table
      SET completed_date = completed_task_date
      WHERE name = task_name
      VALUES(?);
      ', task_name)
    end
  end
end

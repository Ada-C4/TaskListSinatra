require "./lib/database"

module TaskList
  class UseDatabase < Database

  def add_task(task_name, task_description, completed_task_date)
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

  end
end

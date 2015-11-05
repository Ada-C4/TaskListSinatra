require "/lib/database"

module TaskList
  class UseDatabase < Database

  def add_task(task_name)
    @db.execute('
    INSERT INTO tasks_table (name)
    VALUES(?);
    ', task_name)
  end

  def get_tasks
    @db.execute('
    SELECT id, name FROM tasks_table;
    ')
  end

  end
end

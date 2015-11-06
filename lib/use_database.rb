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

    def complete_tasks(task_name_array)
      completed_task_date = "#{Time.now.month}/#{Time.now.day}/#{Time.now.year}"
      task_name_array.each do |info|
        @db.execute('
        UPDATE tasks_table
        SET completed_date = ?
        WHERE name = ?;
        ', completed_task_date, info)
      end
    end

    def delete_tasks(task_name)
      @db.execute('
      DELETE tasks_table
      WHERE name = ?;
      ', task_name)
    end
  end
end

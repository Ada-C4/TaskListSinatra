require "./lib/database"

module TaskList
  class TaskActions < TaskList::Database
    def new_task(name, description=nil, done_date=nil)

      @db.execute('
      INSERT INTO tasks (name, description, done_date)
      Values(?, ?, ?)
      ;', name, description, done_date)
    end

    def existing_task
    end

    def show_tasks
      @db.execute('
      SELECT * FROM tasks;
      ')
    end

    def get_task(id)
      tasks = @db.execute('
      SELECT * FROM tasks WHERE ID = ?;
      ', id)
      return tasks[0]
    end

    def remove_task(del_id)
      @db.execute('
      DELETE FROM tasks WHERE ID = ?;
      ', del_id)
    end

  end
end

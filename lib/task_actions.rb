require "./lib/database"

module TaskList
  class TaskActions < TaskList::Database
    def new_task(name, description=nil, done_date=nil)
      @db.execute('
      INSERT INTO tasks (name, description, done_date)
      Values(?, ?, ?)
      ;', name, description, done_date)
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

    def complete_task(id)
      date = Time.now.strftime("%b %d, %Y")
      @db.execute('
      UPDATE tasks
      SET done_date = ?
      WHERE ID = ?;
      ', date, id)
    end

    def edit_task(id, name, description=nil)
      @db.execute('
      UPDATE tasks
      SET name = ?, description = ?
      WHERE ID = ?;
      ', name, description, id)
    end

  end
end

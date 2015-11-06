require './lib/database.rb'

module TaskList
  class	TaskCreator < Database

  	def create_task(task_name, description = nil, com_date = nil)
  		@db.execute('
  			INSERT INTO tasks (name, description, completed_date)
  			VALUES(?, ?, ?)
  			;', task_name, description, com_date)
  	end

  	def get_tasks
  		@db.execute('
  			SELECT id, name, description, completed_date
  			FROM tasks;
  			')
  	end

    def delete_task(task_id)
    	task_id = task_id.to_i
    	@db.execute('
				DELETE FROM tasks WHERE id = ?
    		;', task_id)
    end

    def complete_task(task_id, completed_time)
      task_id = task_id.to_i
      @db.execute('
        UPDATE tasks SET completed_date = ? WHERE id = ?
      ;', completed_time.to_s, task_id)
    end

    def modify_task_name(task_id, name)
    	task_id = task_id.to_i
    	@db.execute('
    	  UPDATE tasks SET name = ? WHERE id = ?
    	;', name, task_id)
    end

    def modify_task_description(task_id, description)
    	task_id = task_id.to_i
    	@db.execute('
    	  UPDATE tasks SET description = ? WHERE id = ?
    	;', description, task_id)
    end

  end

end

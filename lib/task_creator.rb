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

  end

end

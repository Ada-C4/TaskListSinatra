require 'sinatra'
require './lib/task_creator.rb'

class	TaskSite < Sinatra::Base

	def current_db
		@curr_db ||= TaskList::TaskCreator.new("task-list.db")
	end

	get '/' do
		task_array = current_db.get_tasks
		@all_tasks = []

		task_array.each do |task|
			one_task = {
				id: task[0],
				name: task[1],
				description: task[2],
				completed_date: task[3]
			}
			@all_tasks.push(one_task)
		end

    erb :index
	end

end

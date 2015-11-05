require 'sinatra'
require './lib/task_creator.rb'

class	TaskSite < Sinatra::Base

	def current_db
		@curr_db ||= TaskList::TaskCreator.new("task-list.db")
	end

	def current_list
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
	end

	get '/' do
		current_list
    erb :index
	end

	post '/' do
		task_name = params[:name]
		task_descr = params[:description]
		current_db.create_task(task_name, task_descr)
		current_list
		erb :index
	end

	get "/add_task" do
		erb :add_task
	end

end

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
	def motivation
		motivation = ["You Can Do It!", "You're The Best!", "You're Great!", "Rock On, Cowgirl!", "Work It Out!", "Keep Pushing!", "Yes!", "C'mon Now!"]
		mot_rand = motivation.length - 1
		quote = motivation[rand(0..mot_rand)]
		return quote
	end

	get '/' do
		current_list
		@title = motivation
    erb :index
	end

	post '/' do
		task_name = params[:name]
		task_descr = params[:description]
		current_db.create_task(task_name, task_descr)
		current_list
		@title = motivation
		erb :index
	end

	get "/add_task" do
		erb :add_task
	end

end

require 'sinatra'
require './lib/task_creator.rb'
require 'pry'

class	TaskSite < Sinatra::Base

	def current_db
		@curr_db ||= TaskList::TaskCreator.new("task-list.db")
	end

	def task_ids
		task_ids = []
		@all_tasks[:todo].each do |task|
			task_ids.push(task[:id])
		end
		return task_ids
	end

	def current_list
		task_array = current_db.get_tasks
		@all_tasks = {completed: [], todo: []}
		task_array.each do |task|
			one_task = {
				id: task[0],
				name: task[1],
				description: task[2],
				completed_date: task[3]
			}

			@all_tasks[:completed] << one_task if !one_task[:completed_date].nil?
			@all_tasks[:todo] << one_task if one_task[:completed_date].nil?
		end
	end

	def delete_checked(ids_array)
		ids_array.each do |id|
			current_db.delete_task(id)
		end
	end

	def complete_checked(ids_array)
		completed_time = Time.now
		ids_array.each do |id|
			current_db.complete_task(id, completed_time)
		end
	end

	def new_task
		task_name = params[:name]
		task_descr = params[:description]
		current_db.create_task(task_name, task_descr)
	end

	def update_task_name(id)
		task_name = params[:name]
		current_db.modify_task_name(id, task_name)
	end

	def update_task_description(id)
		task_descr = params[:description]
		current_db.modify_task_description(id, task_descr)
	end

	def delete_task
		@checked = params[:checked]
		delete_checked(@checked)
	end

	def complete_task
		@complete = params[:checked]
		complete_checked(@complete)
	end

	def motivation
		motivation = ["You Can Do It!", "You're The Best!", "You're Great!", "Rock On, Cowgirl!", "Work It Out!", "Keep Pushing!", "Yes!", "C'mon Now!", "I Believe in You!", "Work It!", "Movin' and Shakin'!", "Bang!"]
		mot_rand = motivation.length - 1
		quote = motivation[rand(0..mot_rand)]
		return quote
	end

	get '/' do
		current_list
		@title = motivation
    erb :index
	end

	post '/add_task' do
			delete_task if params[:submit] == "delete"
			complete_task if params[:submit] == "complete"
			new_task if params[:submit] == "Create/Modify"


			@title = motivation
			current_list

			redirect to("/")
	end

	get "/modify" do
		@task = current_db.get_task(params[:task])

		erb :add_task
	end

	post "/modify" do
		task_id = params[:task]
		task = current_db.get_task(task_id)

		update_task_name(task_id) if task[1] != params[:name]
		update_task_description(task_id) if task[2] != params[:description]

		redirect to("/")
	end

	get "/add_task" do
		erb :add_task
	end

end

require 'sinatra'
require './lib/task_creator.rb'
require 'pry'

class	TaskSite < Sinatra::Base

	def current_db
		@curr_db ||= TaskList::TaskCreator.new("task-list.db")
	end

	def get_task(task_id)
		task_array = current_db.get_task(task_id)

		{
			id: task_array[0],
			name: task_array[1],
			description: task_array[2],
			completed_date: task_array[3]
		}
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

	def new_task(task_name, task_descr)
		current_db.create_task(task_name, task_descr)
	end

	def update_task_name(id, name)
		current_db.modify_task_name(id, task_name)
	end

	def update_task_description(id, task_descr)
		current_db.modify_task_description(id, task_descr)
	end

	def delete_completed
		current_db.delete_complete
	end

	def motivation
		motivation = ["You Can Do It!", "You're The Best!", "You're Great!", "Rock On, Cowgirl!", "Work It Out!", "Keep Pushing!", "Yes!", "C'mon Now!", "I Believe in You!", "Work It!", "Movin' and Shakin'!", "Bang!"]
		mot_rand = motivation.length - 1
		quote = motivation[rand(0..mot_rand)]
		return quote
	end

	get '/' do
		@title = motivation

		current_list

    erb :index
	end

	post "/" do
		@title = motivation
		checked = params[:checked]

		unless checked.nil?
			delete_checked(checked) if params[:submit] == "Delete"
			complete_checked(checked) if params[:submit] == "Complete"
		end

		delete_completed if params[:submit] == "Delete All Completed Tasks"

		current_list

		erb :index
	end

	get "/add_task" do
		@form_title = "Add a Task!"
		@button_value = "Add"
		erb :add_task
	end

	post '/add_task' do
		task_name = params[:name]
		task_descr = params[:description]
		new_task(task_name, task_descr)
		redirect to("/")
	end

	get "/modify" do
		@task = current_db.get_task(params[:task])
		@form_title = "Modify Your Task"
		@button_value = "Modify"
		erb :add_task
	end

	post "/modify" do
		task_id = params[:task]
		task = get_task(task_id)
		task_name = params[:name]
		task_descr = params[:description]
		update_task_name(task_id, task_name) if task_name != params[:name]
		update_task_description(task_id, task_descr) if task_descr != params[:description]

		redirect to("/")
	end

end

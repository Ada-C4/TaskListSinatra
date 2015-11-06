require "sinatra"
require "./lib/task_master.rb"
require "pry"

class MySite < Sinatra::Base

	def current_db
		@current_db ||= TaskList::Task.new("tasks.db")
	end

  def index_stuff
    @title = "Your Complete Task List"
    @tasks = TaskList::TaskObject.create_tasks(current_db.get_tasks)
    erb :index
  end

  get "/" do
    index_stuff
  end

  get "/add" do
    @title = "Add a Task!"
    erb :add
  end

  post "/" do
    @task_name = params[:name]
    @task_desc = params[:description]
    @task_date = params[:date]
    current_db.create_task(@task_name, @task_desc, @task_date)
    index_stuff
  end

  post "/update" do
  	completed_tasks = params[:is_complete]
	  	if params["complete"] == "Mark Task(s) Complete"
		    completed_tasks.each do |id|
		      current_db.mark_complete(id)
		    end
		  elsif params["move"] == "Move to Tasks to Complete"
		  	completed_tasks.each do |id|
		      current_db.remove_date(id)
		    end
		  elsif params["delete"] == "Delete Task(s) Permanently"
		    completed_tasks.each do |id|
		      current_db.delete(id)
		    end
		  end

			if params["edit"] == "edit"
				@task_name = params[:name]
		    @task_desc = params[:description]
		    @task_date = params[:date]
				@task_id = params[:id]
				erb :add
			else
    		index_stuff
			end

		# binding.pry
  end

end

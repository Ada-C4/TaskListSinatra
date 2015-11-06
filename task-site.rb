require "sinatra"
require "./lib/database"

class Tasks < Sinatra::Base
  def current_db
    @curr_db ||= TaskList::Database.new("tasks.db")
  end

  get "/" do
    @all_tasks = current_db.get_tasks
    erb :index
  end

  post "/" do
    tasks_to_complete = params[:tasks]
    current_db.update_tasks(tasks_to_complete)
    redirect to("/completed")
  end

  get "/newtask" do
    erb :newtask
  end

  post "/newtask" do
    @new_task = params[:taskname]
    @description = params[:description]
    @date = params[:date]

    current_db.create_task(@new_task, @description, @date)
    redirect to("/")
  end

  get "/completed" do
    @completed_tasks = current_db.get_completed_tasks
    erb :completed
  end


end

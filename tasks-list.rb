require "sinatra"
require "./lib/task_actions"

class TasksList < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::TaskActions.new("allofthetasks.db")
  end

  get "/" do
    @task_array = current_db.show_tasks
    erb :index
  end

  post "/" do
    params.keys.each { |key| current_db.remove_task(key.to_i) }
    @task_array = current_db.show_tasks
    erb :index
  end

  get "/new" do
    erb :new
  end

  post "/new" do
    current_db.new_task(params[:task_name], params[:description])
    @task_array = current_db.show_tasks
    erb :index
  end

end

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

  get "/new" do
    erb :new
  end



end

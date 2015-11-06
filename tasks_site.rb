require "sinatra"
require "./lib/database"

def current_db
  @curr_db ||= TaskList::Database.new("todo_list.db")
end

class Tasks < Sinatra::Base
  get "/" do
    @title = "Your Task List"
    @current_tasks = current_db.get_current_tasks
    @completed_tasks = current_db.get_completed_tasks

    erb :index
  end

  post "/" do
    complete_ids = params[:completed]
    complete_ids.each do |id|
      current_db.complete_task(id)
    end
    redirect to('/')
  end

  get "/new" do
    @title = "Add a new task"
    erb :new
  end

  post "/new" do
    @title = "Add a new task"
    @new_task = params[:task]
    @descr = params[:description]
    @date = params[:date]
    current_db.create_task(@new_task, @descr)
    redirect to('/')
  end
end

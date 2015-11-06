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
    # for tomorrow selves: in index.erb, can add name attributes to each
    # of the submit buttons (so name="complete" and name="delete")
    # then, in this method, capture those values as params[:complete] and params[:delete]
    # use those values in if then statement to tell this method whether to complete a task
    # or to delete a task.  
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

require "sinatra"
require "./lib/use_database"
require "pry"

class TaskSite < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::UseDatabase.new("tasklist.db")
  end

  get "/" do
    @tasks_info = current_db.get_tasks
    @title = "Shit You Should Be Doing"
    erb :index
  end

  get "/add_task" do
    @title = "Write That Shit Down!"
    erb :add_task
  end

  post "/" do
    @title = "Shit You Should Be Doing"
    current_db.add_task(params[:name], params[:description], params[:completed_date])
    @tasks_info = current_db.get_tasks
    erb :index
  end

  post "/complete" do
    current_db.complete_tasks(params[:completed])
    redirect to ('/')
  end

  get "/delete_confirmation" do
    @title = "Clean That Shit?"
    @to_delete = params[:name]
    erb :delete_confirmation
  end

  post "/delete" do
    to_delete = params[:task_name]
    current_db.delete_task(to_delete)
    redirect to ('/')
  end

end

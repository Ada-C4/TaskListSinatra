require "sinatra"
require "./lib/use_database"
# require "./lib/database"

class TaskSite < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::UseDatabase.new("tasklist.db")
  end

  get "/" do
    @tasks = current_db.get_tasks
    @title = "Shit You Should Be Doing"
    erb :index
  end

  get "/add_task" do
    @title = "Write That Shit Down!"
    erb :add_task
  end

  post "/" do
    @title = "Shit You Should Be Doing"
    current_db.add_task(params[:name], params[:description])
    @tasks = current_db.get_tasks
    erb :index
  end
end

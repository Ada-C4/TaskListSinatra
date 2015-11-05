require "sinatra"
require "./lib/database"
require "./lib/taskbase"

class TaskSite < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::TaskBase.new("tasks.db")
  end

  get "/" do
    @tasks = current_db.get_tasks
    erb :index
  end

  get "/new" do
    erb :new
  end

  post "/new" do
    @new_name = params[:name]
    @new_descr = params[:description]
    @new_date = params[:date_completed]
    current_db.create_task(@new_name, @new_descr, @new_date)
    @tasks = current_db.get_tasks
    erb :index
  end

end

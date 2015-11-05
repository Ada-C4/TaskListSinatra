require "sinatra"
require "./lib/database"

class TaskSite < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::Database.new("tasks.db")
  end

  get "/" do
    @title = "Unicorn Task List"
    @tasks = current_db.get_tasks
    erb :index
  end

  get "/new" do
    @title = "Add New Task"
    erb :new
  end

  post "/new" do
    @name = params[:name]
    @description = params[:description]
    current_db.create_tasks(@name, @description)
    redirect to('/')
  end

  get "/mark_complete" do
    @tasks = current_db.get_tasks
    @title = "Complete Tasks"
    erb :mark_complete
  end



end

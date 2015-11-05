require "sinatra"
require "./lib/database"

class TaskSite < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::Database.new("tasks.db")
  end

  get "/" do
    @tasks = current_db.get_tasks
    erb :index
  end

  get "/new" do
    erb :new
  end

  post "/new" do
    @name = params[:name]
    @description = params[:description]
    current_db.create_tasks(@name, @description)
    erb :index
  end



end

require "sinatra"
require "./lib/database"

class TaskList < Sinatra::Base

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
    @new_name = params[:name]
    @descr = params[:description]
    current_db.create_task(@new_name, @descr)
    erb :index
  end


end

require "sinatra"
require "./lib/database"
require "pry"

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
    @new_name = params[:name]
    @descr = params[:description]
    current_db.create_task(@new_name, @descr)
    @tasks = current_db.get_tasks
    erb :index
  end



  get "/delete_all" do
    erb :delete
  end

  post "/delete_all" do
    current_db.delete_tasks
    erb :index
  end

  get "/delete/:name" do
    @delete_name = params[:name]
    current_db.delete_single_task(@delete_name)
    redirect to("/")
  end

  get "/complete" do
    binding.pry
    @completed_task = params[:tasks]
  end


end

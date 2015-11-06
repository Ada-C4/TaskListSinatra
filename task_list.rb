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
    @is_update1 = @@is_update
    binding.pry
    if @@is_update
      current_db.update_task(@@update_name, @new_name, @descr)
    else
      current_db.create_task(@new_name, @descr)
    end
    @tasks = current_db.get_tasks
    @@is_update = false
    redirect to("/")
  end

  get "/delete_all" do
    erb :delete
  end

  post "/delete_all" do
    current_db.delete_tasks
    redirect to("/")
  end

  get "/delete/:name" do
    @delete_name = params[:name]
    current_db.delete_single_task(@delete_name)
    redirect to("/")
  end

  get "/update/:name" do
    @@is_update = true
    @@update_name = params[:name]
  redirect to("/new")
  end

  get "/complete" do
    @completed_task = params[:tasks]
    @completed_task.each do |task|
      current_db.completed_task(task)
    end
    redirect to ("/")
  end



end

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
    @is_update1 = @@is_update
    erb :new
  end

  post "/new" do
    @new_name = params[:name]
    @descr = params[:description]
    if @@is_update
      current_db.update_task(@@update_id, @new_name, @descr)
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

  get "/delete/:id" do
    @delete_id = params[:id]
    current_db.delete_single_task(@delete_id)
    redirect to("/")
  end

  get "/update/:id" do
    @@is_update = true
    @@update_id = params[:id]
  redirect to("/new")
  end

  get "/complete" do
    @completed_task = params[:tasks_id]
    @completed_task.each do |task_id|
      current_db.completed_task(task_id)
    end
    redirect to ("/")
  end



end

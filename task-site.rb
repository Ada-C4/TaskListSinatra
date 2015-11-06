require "sinatra"
require "./lib/database"

class TaskSite < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::Database.new("tasks.db")
  end

  def mark_complete(ids)
    completed_date = Time.now.to_s
    ids.each do |id|
      current_db.complete_tasks(completed_date, id)
    end
  end

  def delete(ids)
    ids.each do |id|
      current_db.delete_tasks(id)
    end
  end

  # def update(ids)
  #   ids.each do  |id|
  #     current_db.edit_tasks(id)
  # end

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

  post "/mark_complete" do
    mark_complete(params[:complete])
    redirect to('/')
  end

  get "/delete" do
    @tasks = current_db.get_tasks
    @title = "Delete A Task"
    erb :delete
  end

  post "/delete" do
    delete(params[:delete])
    redirect to('/')
  end


end

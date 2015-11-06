require "sinatra"
require "./lib/database"
require "pry"

class ListofTasks < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::TaskManager.new("taskbase.db")
  end

  get "/" do
    @tasks = current_db.select_tasks
    erb :index
  end

  get "/new" do
    erb :new
  end

  post "/" do
    @task = params[:task]
    @description = params[:description]
    @completed_date = params[:completed_date]
    current_db.new_task(@task, @description, @completed_date)
    @tasks = current_db.select_tasks
    erb :index
  end

  get "/modify" do
    @tasks = current_db.select_tasks
    erb :modify
  end

  post "/modify" do
    params[:completed].each do |id|
      current_db.completed_tasks(id)
    end
    @tasks = current_db.select_tasks
    erb :modify
  end

  get "/delete" do
    @tasks = current_db.select_tasks
    erb :delete
  end

  post "/delete" do
    params[:deleted].each do |id|
      current_db.delete_tasks(id)
    end
    @tasks = current_db.select_tasks
    erb :delete
  end

end

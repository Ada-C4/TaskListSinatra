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

  get "/task/new" do
    erb :new
  end

  post "/task/new" do
    @task = params[:task]
    @description = params[:description]
    @completed_date = params[:completed_date]
    current_db.new_task(@task, @description, @completed_date)
    @tasks = current_db.select_tasks
    erb :index
  end

  get "/task/complete" do
    @tasks = current_db.select_tasks
    erb :complete
  end

  post "/task/complete" do
    params[:completed].each do |id|
      current_db.completed_tasks(id)
    end
    @tasks = current_db.select_tasks
    erb :index
  end

  get "/task/delete" do
    @tasks = current_db.select_tasks
    erb :delete
  end

  post "/task/delete" do
    params[:deleted].each do |id|
      current_db.delete_tasks(id)
    end
    @tasks = current_db.select_tasks
    erb :index
  end

  get "/edit_choice" do
    erb :edit_choice
  end

  get "/task/:task" do
    erb :edit
  end
end

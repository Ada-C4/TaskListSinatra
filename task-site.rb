require 'sinatra'
require './lib/database'

class TaskSite < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::Database.new("tasklist.db")
  end

  get "/" do
    @tasks = current_db.get_tasks
    erb :index
  end

  get "/new" do
    erb :new
  end

  post "/" do
    @name = params[:name]
    @descr = params[:descr]
    current_db.create_task(@name, @descr) if !@name.nil?
    current_db.add_completion
    @tasks = current_db.get_tasks
    erb :index
  end


end

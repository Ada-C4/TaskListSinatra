require 'pry'
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
    @title = "Enter your shit"
    erb :new
  end

  post "/edit" do
    @title = "Edit your shit"
    binding.pry
    @id = params[:completed]
    @name = current_db.get_name(@id)
    @descr = current_db.get_descr(@id)
    erb :new
  end

  post "/" do
    @name = params[:name]
    @descr = params[:descr]
    @id = params[:id]
    # if !@name.nil? && @id.nil?
    #   current_db.create_task(@name, @descr)
    # else
    #   current_db.update_task(@name, @descr, @id)

    params[:completed].each do |id|
      current_db.add_completion(id)
    end
    params[:completed].each do |id|
      current_db.delete_task(id)
    end
    @tasks = current_db.get_tasks
    erb :index
  end


end

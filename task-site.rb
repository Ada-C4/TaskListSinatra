require 'sinatra'
require './lib/database'
require "pry"

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

  get "/edit" do
    # binding.pry
    @title = "Edit your shit"
    @id = params[:id]
    # @name = current_db.get_name(@id)
    @descr = current_db.get_descr(@id)
    erb :new
  end

  # post "/edit" do
  #   @title = "Edit your shit"
  #   @id = params[:completed]
  #   @name = current_db.get_name(@id)
  #   @descr = current_db.get_descr(@id)
  #   erb :new
  # end

  post "/" do
    # binding.pry
    @name = params[:name]
    @descr = params[:descr]
    @id = params[:id]
    # I think the below method will work for updating once other issues are resolved
    if !@name.nil? && @id.nil?
      current_db.create_task(@name, @descr)
    elsif params[:submit] == "MARK COMPLETE"
      params[:completed].each do |id|
        current_db.add_completion(id)
      end
    elsif params[:delete] == "DELETE"
      params[:completed].each do |id|
        current_db.delete_task(id)
      end
    else
      current_db.update_task(@name, @descr, @id)
    end

    # if !params[:completed].nil?
    #   params[:completed].each do |id|
    #     current_db.add_completion(id)
    #   end

    # end
    @tasks = current_db.get_tasks
    erb :index
  end
end

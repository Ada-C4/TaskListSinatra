require "sinatra"
require "./lib/database"

class TaskList < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::Database.new("taskbase.db")
  end

  get "/" do
    @tasks = current_db.select_tasks
    erb :index
  end


end

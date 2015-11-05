require "sinatra"
require "./lib/database"
require "./lib/taskbase"

class TaskSite < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::TaskBase.new("tasks.db")
  end

  get "/" do
    @tasks = current_db.get_tasks
    erb :index
  end

end

require "sinatra"
require "./lib/task_actions"

class TasksList < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::TaskActions.new("allofthetasks.db")
  end

  get "/" do
    current_db
    erb :index
  end



end

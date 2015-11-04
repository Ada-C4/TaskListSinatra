require "sinatra"

class TasksList < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::Database.new("allofthetasks.db")
  end

  get "/" do
    current_db
    erb :index
  end



end

require "sinatra"
require "./lib/database"

def current_db
  @curr_db ||= TaskList::Database.new("todo_list.db")
end

class Tasks < Sinatra::Base
  get "/" do
    "Hello"
  end

  get "/new" do
    erb :new
  end

  post "/new" do
    @new_task = params[:task]
    @descr = params[:description]
    @date = params[:date]
    current_db.create_task(@new_task, @descr)
    erb :new
  end
end

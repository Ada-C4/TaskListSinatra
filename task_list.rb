require "sinatra"

class TaskList < Sinatra::Base

  get "/" do
    erb :index
  end


end

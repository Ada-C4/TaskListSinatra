require "sinatra"

class TasksList < Sinatra::Base

  get "/" do
    erb :index
  end



end

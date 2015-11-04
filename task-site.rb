require "sinatra"
#put something here later

class TaskList < Sinatra::Base

  get "/" do
    erb :index
  end


end

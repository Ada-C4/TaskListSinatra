require "sinatra"

class TaskSite < Sinatra::Base

  get "/" do
    erb :index
  end

end

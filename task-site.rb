require "sinatra"
require "./lib/database"

class TaskSite < Sinatra::Base

  get "/" do
    erb :index
  end

end

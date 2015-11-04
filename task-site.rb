require "sinatra"
require "./lib/database"

class TaskList < Sinatra::Base

  get "/" do
    erb :index
  end


end

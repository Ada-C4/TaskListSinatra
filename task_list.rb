require "sinatra"

class TaskList < Sinatra::Base

  get "/" do
    erb :index
  end

  get "/new" do
    erb :new
  end

  post "/new" do
    erb :index
  end


end

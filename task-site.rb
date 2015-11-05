require "sinatra"
require "./lib/database"

class Tasks < Sinatra::Base
  get "/" do
    erb :index
  end

  get "/newtask" do
    erb :newtask
  end
end

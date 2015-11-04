require "sinatra"
require "./lib/database"

class Tasks < Sinatra::Base
  get "/" do
    "Hello" 
  end
end

require "sinatra"

class TaskList < Sinatra::Base
  get "/" do
    "Hello World"
  end
end

require "sinatra"
require "pry"
require "./lib/task_actions"

class TasksList < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::TaskActions.new("allofthetasks.db")
  end

  def delete_tasks(ids_array)
    ids_array.each { |id| current_db.remove_task(id.to_i) }
    return params
  end

  def display_tasks
    @task_array = current_db.show_tasks
    erb :index
  end

  get "/" do
    display_tasks
  end

  post "/" do
    if params[:submit] == "delete" && params[:ids] != nil
      ids = params[:ids]
      @task_array = ids.map{ |id| current_db.get_task(id.to_i)}
      @method = :delete
      erb :delete_confirmation
    else
      display_tasks
    end
  end

  post "/delete_confirmation" do
    binding.pry
    if params[:submit] == "yes"
      delete_tasks(params[:ids])
    end
    display_tasks
  end

  get "/new" do
    erb :new
  end

  post "/new" do
    current_db.new_task(params[:task_name], params[:description])
    display_tasks
  end

end

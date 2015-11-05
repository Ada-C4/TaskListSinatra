require "sinatra"
require "pry"
require "./lib/task_actions"

class TasksList < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::TaskActions.new("allofthetasks.db")
  end

  def delete_task(ids_array)
    ids_array.each { |id| current_db.remove_task(id.to_i) }
    return params
  end

  get "/" do
    @task_array = current_db.show_tasks
    erb :index
  end

  post "/" do
    if params[:submit] == "delete" && params[:ids] != nil
      @method = :delete
      ids = params[:ids]
      @task_array = ids.map{ |id| current_db.get_task(id.to_i)}
      erb :delete_confirmation
      # delete_task(params[:ids])
    else
      @task_array = current_db.show_tasks
      erb :index
    end
  end

  get "/new" do
    erb :new
  end

  post "/new" do
    current_db.new_task(params[:task_name], params[:description])
    @task_array = current_db.show_tasks
    erb :index
  end

end

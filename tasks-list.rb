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
    ids = params[:ids]
    if params[:submit] == "delete" && ids != nil
      @task_array = ids.map{ |id| current_db.get_task(id.to_i)}
      @method = :delete
      erb :delete_confirmation
    elsif params[:submit] == "complete" && ids != nil
      ids.each { |id| current_db.complete_task(id.to_i)}
      display_tasks
    elsif params[:submit] == "edit" && ids != nil && ids.length == 1
      @id = params[:ids][0].to_i
      erb :new
    else
      display_tasks
    end
  end

  post "/delete_confirmation" do
    if params[:submit] == "yes"
      delete_tasks(params[:ids])
    end
    redirect to('/')
  end

  get "/new" do
    if @id
      @task_info = current_db.get_task
      @update = true
    else
      @update = false
    end
    erb :new
  end

  post "/new" do
    if params[:submit] == "update"
      current_db.edit_task(     )
    elsif params[:submit] == "new"
      current_db.new_task(params[:task_name], params[:description])
    end
    display_tasks
  end

end

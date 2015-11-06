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

  get "/" do
    @task_array = current_db.show_tasks
    erb :index
  end

  post "/" do
    ids = params[:ids]
    if params[:submit] == "delete" && ids != nil
      @task_array = ids.map{ |id| current_db.get_task(id.to_i)}
      @method = :delete
      erb :delete_confirmation
    elsif params[:submit] == "complete" && ids != nil
      ids.each { |id| current_db.complete_task(id.to_i)}
      redirect to('/')
    elsif params[:submit] == "edit" && ids != nil && ids.length == 1
      @task = current_db.get_task(params[:ids][0].to_i)
      @update = true
      erb :new
    else
      redirect to('/')
    end
  end

  post "/delete_confirmation" do
    if params[:submit] == "yes"
      delete_tasks(params[:ids])
    end
    redirect to('/')
  end

  get "/new" do
    if !@task.nil?
      @task_info = current_db.get_task
    else
      @update = false
    end
    erb :new
  end

  post "/new" do
    if params[:submit] == "update"
      binding.pry
      # current_db.edit_task(     )
    elsif params[:submit] == "new"
      current_db.new_task(params[:task_name], params[:description])
    end
    redirect to('/')
  end

end

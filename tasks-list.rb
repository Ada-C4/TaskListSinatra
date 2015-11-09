require "sinatra"
require "./lib/task_actions"

class TasksList < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::TaskActions.new("allofthetasks.db")
  end

  def delete_tasks(ids_array)
    ids_array.each { |id| current_db.remove_task(id.to_i) }
    return params
  end

  def delete_confirm(ids)
    @task_array = ids.map{ |id| current_db.get_task(id.to_i)}
    @method = :delete
    erb :delete_confirmation
  end

  def update(params)
    current_db.edit_task(params[:id], params[:task_name], params[:description])
    redirect to('/')
  end

  def complete(ids)
    ids.each { |id| current_db.complete_task(id.to_i)}
    redirect to('/')
  end

  def edit(params)
    @task = current_db.get_task(params[:ids][0].to_i)
    @update = true
    erb :new
  end


  get "/" do
    @task_array = current_db.show_tasks
    erb :index
  end

  post "/" do
    ids = params[:ids]
    if params[:submit] == "delete" && ids != nil
      delete_confirm(ids)
    elsif params[:submit] == "update"
      update(params)
    elsif params[:submit] == "complete" && ids != nil
      complete(ids)
    elsif params[:submit] == "edit" && ids != nil && ids.length == 1
      edit(params)
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
    if params[:submit] == "new"
      current_db.new_task(params[:task_name], params[:description])
    end
    redirect to('/')
  end

end

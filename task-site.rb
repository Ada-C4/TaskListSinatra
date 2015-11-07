require "sinatra"
require "./lib/database"
require "./lib/taskbase"

class TaskSite < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::TaskBase.new("tasks.db")
  end

  get "/" do
    @tasks = current_db.get_tasks
    erb :index
  end

  get "/christmas" do
    @tasks = current_db.get_tasks
    erb :index_christmas
  end

  post "/christmas" do
    @to_delete = params[:tasks_to_delete]
    if !@to_delete.nil?
      @to_delete.each do |task|
        current_db.delete_task(task.to_i)
      end
    end
    @to_edit = params[:task_to_edit]
    if !@to_edit.nil?
      redirect to("/edit?id=#{@to_edit}")
    end
    @tasks = current_db.get_tasks
    erb :index_christmas
  end

  post "/" do
    @to_delete = params[:tasks_to_delete]
    if !@to_delete.nil?
      @to_delete.each do |task|
        current_db.delete_task(task.to_i)
      end
    end
    @to_edit = params[:task_to_edit]
    if !@to_edit.nil?
      redirect to("/edit?id=#{@to_edit}")
    end
    @tasks = current_db.get_tasks
    erb :index
  end

  get "/new" do
    erb :new
  end

  post "/new" do
    @new_name = params[:name]
    @new_descr = params[:description]
    @new_date = params[:date_completed]
    current_db.create_task(@new_name, @new_descr, @new_date)
    @tasks = current_db.get_tasks
    redirect to('/')
  end

  get "/edit" do
    @id = params[:id]
    @single_task = current_db.get_single_task(@id.to_i).flatten
    @name = @single_task[1]
    @description = @single_task[2]
    @date = @single_task[3]
    erb :edit
  end

  post "/edit" do
    @edited_name = params[:name]
    @edited_descr = params[:description]
    @edited_date = params[:date_completed]
    @id = params[:id]
    current_db.edit_task(@id, @edited_name, @edited_descr, @edited_date)
    @tasks = current_db.get_tasks
    redirect to('/')
  end

end

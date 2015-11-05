require "sinatra"
require "./lib/database"
require "./lib/taskbase"
require "pry"

class TaskSite < Sinatra::Base

  def current_db
    @curr_db ||= TaskList::TaskBase.new("tasks.db")
  end

  get "/" do
    @in_progress = []
    @completed = []
    @tasks = current_db.get_tasks
    # @tasks.each do |task|
    #   if task[3] = ""
    #     @in_progress.push(task)
    #   else
    #     @completed.push(task)
    #   end
    # end
    erb :index
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
    binding.pry
    # @name =
    # @description =
    # @date =
    erb :edit
  end

  post "/edit" do

  end

end

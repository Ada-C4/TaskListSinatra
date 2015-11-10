require "sinatra"
require "./lib/database"

def current_db
  @curr_db ||= TaskList::Database.new("todo_list.db")
end

class Tasks < Sinatra::Base
  get "/" do
    @title = "Your Task List"
    @current_tasks = current_db.get_current_tasks
    @completed_tasks = current_db.get_completed_tasks
    erb :index
  end

  post "/" do
    @submit = params[:submit]
    if @submit == "Complete Task(s)"
      puts "the complete part of the if"
      complete_ids = params[:checked]
      complete_ids.each do |id|
        current_db.complete_task(id)
      end
      redirect to('/')
    elsif @submit == "Delete Task(s)"
      puts "the delete part of the if"
      delete_ids = params[:checked]
      delete_ids.each do |id|
        current_db.delete_task(id)
      end
      redirect to('/')
    else
      puts "first part of edit"
      @edit_id = params[:checked]
      binding.pry
      puts "second part of edit"
      redirect to('/edit')
    end
  end

  get "/edit" do
    @title = "Edit task"
    erb :edit
  end

  post "/edit" do
    @title = "Add a new task"
    id = params[:task_id]
    name = params[:task]
    description = params[:description]
    current_db.edit_task(id, name, description)
    redirect to('/')
  end

  get "/new" do
    @title = "Add a new task"
    erb :new
  end

  post "/new" do
    @title = "Add a new task"
    @new_task = params[:task]
    @descr = params[:description]
    @date = params[:date]
    current_db.create_task(@new_task, @descr)
    redirect to('/')
  end
end

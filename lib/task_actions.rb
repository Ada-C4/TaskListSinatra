require "./lib/database"

module TaskList
  class TaskActions < TaskList::Database

    # Ricky - I commented this out because it is redundant - will inherit this from parent class
    # def initialize(db_name)
    #   #not sure if it's passing an instance of database class the correct way
    #
    #   @db = SQLite3::Database.new(db_name)
    # end

    def new_task(name, description=nil, done_date=nil)

      @db.execute('
      INSERT INTO tasks (name, description, done_date)
      Values(?, ?, ?)
      ;', name, description, done_date)
    end

    def existing_task
    end

    def show_tasks
    end

  end
end

require_relative "db_driver"

module TaskList
  class Database
    def initialize(db_name)
      @db = DBDriver.new(db_name)
    end

    def delete_schema
      @db.delete_schema
    end

    def create_schema
      @db.execute('
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NULL,
        date TEXT NULL
      );')
    end
  end

end

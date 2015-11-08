# Figure out which DB we're using
DB_DRIVER = (ENV["RACK_ENV"] == "production") ? :pg : :sqlite3

require DB_DRIVER.to_s

class DBDriver
  def initialize(db_name)
    case DB_DRIVER
    when :sqlite3
      @db = SQLite3::Database.new(db_name)
    when :pg
      @db = PG::Connection.new(ENV["DATABASE_URL"])
    end
  end

  def execute(query, *args)
    case DB_DRIVER
    when :sqlite3
      return @db.execute(query, *args)
    when :pg
      # First we need to transform the bound variable placeholders
      # because SQLite uses ? and PG uses $1, $2, $3, etc.
      # HOWEVER
      # We can't actually parse this SQL query! So I'm just going to
      # split on each ? and combine them again with the PG style.
      # WARNING
      # Because I can't parse the SQL query, we might end up replacing
      # literal question marks with the variable bind code. :( :( :(
      var_num = 0
      query = query.split("?").reduce("") do |fixed, orig|
        var_str = var_num > 0 ? "$#{var_num}" : ""
        var_num += 1

        next fixed + var_str + orig
      end

      # We also need to make sure that we use PG's sequence data type
      # because unlike SQLite, it does not integer make primary keys
      # autoincrement by default.
      query.gsub!(/integer primary key/i, "SERIAL PRIMARY KEY")

      return @db.exec_params(query, args).values
    end
  end

  def delete_schema
    case DB_DRIVER
    when :sqlite3
      db_file = @db.database_list[0][2] # maybe there's a better way?
      @db.close unless @db.closed?

      File.delete(db_file)
    when :pg
      @db.exec('
        DROP SCHEMA public CASCADE;
        CREATE SCHEMA public;
      ')
    end
  end
end

module TaskList
	class TaskObject

    attr_reader :id, :name, :description, :completed_date

    def initialize(id, name, description, completed_date)
			@id = id
      @name = name
      @description = description
      @completed_date = completed_date
    end

    def self.create_tasks(array)
      array.map { |a| TaskObject.new(a[0], a[1], a[2], a[3])  }
    end
  end
end

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name,grade,id= nil)
    @name = name
    @grade=grade
    @id=id
  end


  def self.create_table
        sql =  <<-SQL
        CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
        )
        SQL
        DB[:conn].execute(sql)
  end

  def save
        episode2=<<-SQL
        INSERT INTO students(name,grade)
        VALUES (?,?)
        SQL

        DB[:conn].execute(episode2,self.name,self.grade)
        @id=  DB[:conn].execute("SELECT id FROM students WHERE name = ?", @name)[0][0]
  end


   def self.drop_table
     comeback=<<-SQL
          DROP TABLE students
          SQL
          DB[:conn].execute(comeback)
   end

   def self.create(name:,grade:)
     anakin=Student.new(name,grade)
     anakin.save
     anakin
end





end

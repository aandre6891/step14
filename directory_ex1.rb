def add_student(name, cohort)
    @students << {name: name, cohort: cohort}
  end
  
  def try_load_students
    filename = ARGV.first # first argument from the command line
    return if filename.nil? # get out of the method if it isn't given
    if File.exist?(filename) # if it exists
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
    else # if it doesn't exist
      puts "Sorry, #{filename} doesn't exist."
      exit # quit the program
    end
  end
  
  def input_students(selection)
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    # get the first name
    name = gets.chomp
    # while the name is not empty, repeat this code
    while !name.empty? do
      # add the student hash to the array
      add_student(name, :november)
      puts "Now we have #{@students.count} students"
      # get another name from the user
      name = gets.chomp
    end
  end
  
  def load_students(selection)
    file = File.open("students.csv", "r")
    file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_student(name, cohort.to_sym)
    end
    file.close
  end
  
  def save_students
    # open the file for writing
    file = File.open("students.csv", "w")
    # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
    file.close
  end
  
  @students = [] # array accessible in all methods
  
  def interactive_menu
    loop do
      print_menu
      process(gets.chomp)
    end
  end
  
  def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit" # 9 because we'll be adding more items
  end
  
  def show_students
    print_header
    print_student_list
    print_footer
  end
  
  def process(selection)
    case selection
    when "1"
      input_students("1")
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students("4")
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
  
  def print_header
    puts "The students of Villains Academy"
    puts "-------------"
  end
  
  def print_student_list
    @students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
  
  def print_footer
    puts "Overall, we have #{@students.count} great students"
  end
  
  try_load_students
  interactive_menu
require_relative 'transfer_manager.rb'

class Operator

  def initialize
    @transfer = Transfer.new
    @welcome_text = "Welcome to photo_transfer.

    Type 'q' and 'enter' to SET the camera directory.
    Type 'w' and 'enter' to SET the directory for photos to be transferred to.
    
    Type 'e' and 'enter' to GET the camera directory.
    Type 'r' and 'enter' to GET the directory for photos to be transferred to.

    Type 'd' and 'enter' to transfer all photos from your camera to folders on your computer according to the date taken.
    Type 'm' and 'enter' to transfer all photos from your camera to folders on your computer according to the month taken.
    Type 'y' and 'enter' to run current test method.
    Type 'x' and 'enter' to quit this program."
  end

  def terminal_flag_processor
    if ARGV[0] == 'date'
      @transfer.transfer_photos_to_directories("day")
    elsif ARGV[0] == 'month'
      @transfer.transfer_photos_to_directories("month")
    else
      function_selector
    end
  end

  def function_selector
    puts @welcome_text
    input = STDIN.gets.chomp
    case input

      when 'q'
        puts "Type the directory in the following format, then press enter:
        /Users/rory/Documents/test_camera/"
        @transfer.camera_dir = gets.chomp
        self.function_selector

      when 'w'
        puts "Type the directory in the following format, then press enter:
        /Users/rory/Documents/tester/"
        @transfer.computer_dir = gets.chomp
        self.function_selector


      when 'e'
        if @transfer.camera_dir == nil
          puts "\n" + "Camera directory set to default: /Users/rory/Documents/test_camera/\n\n"
        else
          puts "\n" + "Camera directory: " + @transfer.camera_dir + "\n\n"
        end
        self.function_selector

      when 'r'
        if @transfer.computer_dir == nil
          puts "\n" + "Set to default: /Users/rory/Documents/tester/\n\n"
        else
          puts "\n" + "Computer directory: " + @transfer.computer_dir + "\n\n"
        end
        self.function_selector


      when 'd'
        @transfer.transfer_photos_to_directories("day")
      when 'm'
        @transfer.transfer_photos_to_directories("month")
      when 'y'
        Transfer.create_year_and_month_directories(@transfer.file_name_time_array, @transfer.computer_dir)
        # @transfer.transfer_to_year_and_month_directories
      when 'x'
        exit
      else
        puts "Please enter a valid character"
        self.function_selector
    end
  end

end


# Transfer.make_folder_name_month(Time.new(1986, 03, 07, 18, 15))

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

    Type 'del' and 'enter' to delete all files in 'tester' directory.

    Type 'y' and 'enter' to run current test method.
    Type 'x' and 'enter' to quit this program."
  end

  def terminal_flag_processor
    if ARGV[0] == 'date'
      @transfer.transfer_photos_to_directories(:day)
    elsif ARGV[0] == 'month'
      @transfer.transfer_photos_to_directories(:month)
    else
      function_selector
    end
  end

  # Code below is not refactored into smaller methods as it reads better like a menu.
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
        log_header
        @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.files_with_exif, :day, :exif)
        @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_media, :day, :unsorted_media)
        @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_files, :day, :unsorted_files)
        @transfer.log.create_log_file(@transfer.computer_dir)
      when 'm'
        log_header
        @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.files_with_exif, :month, :exif)
        @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_media, :month, :unsorted_media)
        @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_files, :month, :unsorted_files)
        @transfer.log.create_log_file(@transfer.computer_dir)
      when 'del'
        dir = @transfer.computer_dir
        puts "Are you sure you want to delete all files in " + dir + "?"
        puts "Type 'y' to proceed"
        input = gets.chomp
        @transfer.dir_mgr.delete_all_in_folder(dir) if input == 'y'
        self.function_selector
      when 'y'
        puts "files_with_exif BELOW"
        puts @transfer.files_with_exif
        puts
        puts "unsorted_media BELOW"
        puts @transfer.unsorted_media
        puts
        puts "unsorted_files BELOW"
        puts @transfer.unsorted_files
        # puts "No method set"
        self.function_selector
      when 'x'
        exit
      else
        puts "Please enter a valid character"
        self.function_selector
    end
  end

  def log_header
    @transfer.log.log_text << "SOURCE: " + @transfer.camera_dir
    @transfer.log.log_text << "DESTINATION: " + @transfer.computer_dir
    @transfer.log.log_text << "Transferred at :" + Time.new.to_s + "\n"
  end

end

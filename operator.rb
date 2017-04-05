require_relative 'transfer_manager.rb'

class Operator

  def initialize
    @transfer = Transfer.new
    @welcome_text = "Welcome to photo_transfer.

    Type 'q' and 'enter' to SET the source directory.
    Type 'w' and 'enter' to SET the destination directory.

    Type 'e' and 'enter' to GET the source directory.
    Type 'r' and 'enter' to GET the destination directory.

    Type 'd' and 'enter':
      Photos & videos with EXIF data will be sorted into dated folders.
      Photos & videos without EXIF data will be copied to the 'Unsorted Media' folder.
      All other files will be copied to the 'Unsorted Files' folder.

    Type 'm' and 'enter':
      Photos & videos with EXIF data will be sorted into month and year folders.
      Photos & videos without EXIF data will be copied to the 'Unsorted Media' folder.
      All other files will be copied to the 'Unsorted Files' folder.

    Type 'dx' and 'enter':
      Photos & videos with EXIF data will be sorted into dated folders.
      All other files will be sorted into dated folders based on file creation date*.

    Type 'mx' and 'enter':
      Photos & videos with EXIF data will be sorted into dated folders.
      All other files will be sorted into dated folders based on file creation date*.

    Type 'del' and 'enter' to delete all files in 'tester' directory.

    Type 'y' and 'enter' to run current test method.
    Type 'x' or 'quit' and 'enter' to quit this program."
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

  def function_selector
    puts @welcome_text
    input = STDIN.gets.chomp
    case input
      when 'q'
        set_source_directory
        self.function_selector
      when 'w'
        set_destination_directory
        self.function_selector
      when 'e'
        get_source_directory
        self.function_selector
      when 'r'
        get_destination_directory
        self.function_selector
      when 'd'
        log_header
        day_unsorted
        @transfer.log.create_log_file(@transfer.computer_dir)
      when 'm'
        log_header
        month_unsorted
        @transfer.log.create_log_file(@transfer.computer_dir)
      when 'dx'
        log_header
        day_all_sorted
        @transfer.log.create_log_file(@transfer.computer_dir)
      when 'mx'
        log_header
        month_all_sorted
        @transfer.log.create_log_file(@transfer.computer_dir)
      when 'del'
        delete_destination_contents
        self.function_selector
      when 'y'
        test_method
        self.function_selector
      when 'x'
        exit
      when 'quit'
        exit
      else
        puts "Please enter a valid character"
        puts "Type 'x' or 'quit' and 'enter' to quit this program."
        self.function_selector
    end
  end

  def set_source_directory
    puts "Type the directory in the following format, then press enter:
    /Users/rory/Documents/test_camera/"
    @transfer.camera_dir = gets.chomp
  end

  def set_destination_directory
    puts "Type the directory in the following format, then press enter:
    /Users/rory/Documents/tester/"
    @transfer.computer_dir = gets.chomp
  end

  def get_source_directory
    if @transfer.camera_dir == nil
      puts "\n" + "source directory set to default: /Users/rory/Documents/test_camera/\n\n"
    else
      puts "\n" + "source directory: " + @transfer.camera_dir + "\n\n"
    end
  end

  def get_destination_directory
    if @transfer.computer_dir == nil
      puts "\n" + "Set to default: /Users/rory/Documents/tester/\n\n"
    else
      puts "\n" + "Computer directory: " + @transfer.computer_dir + "\n\n"
    end
  end

  def log_header
    @transfer.log.log_text << "SOURCE: " + @transfer.camera_dir
    @transfer.log.log_text << "DESTINATION: " + @transfer.computer_dir
    @transfer.log.log_text << "Transferred at :" + Time.new.to_s + "\n"
  end

  def day_unsorted
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.files_with_exif, :day, :sort)
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_media, :day, :unsorted_media)
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_files, :day, :unsorted_files)
  end

  def month_unsorted
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.files_with_exif, :month, :sort)
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_media, :month, :unsorted_media)
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_files, :month, :unsorted_files)
  end

  def day_all_sorted
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.files_with_exif, :day, :sort)
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_media, :day, :sort)
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_files, :day, :sort)
  end

  def month_all_sorted
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.files_with_exif, :month, :sort)
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_media, :month, :sort)
    @transfer.transfer_photos_to_directories(@transfer.camera_dir, @transfer.computer_dir, @transfer.unsorted_files, :month, :sort)
  end

  def delete_destination_contents
    dir = "/Users/rory/Documents/tester/"
    puts "Are you sure you want to delete all files in " + dir + "?"
    puts "Type 'y' to proceed"
    input = gets.chomp
    @transfer.dir_mgr.delete_all_in_folder(dir) if input == 'y'
  end

  def test_method
    puts "files_with_exif BELOW"
    puts @transfer.files_with_exif
    puts
    puts "unsorted_media BELOW"
    puts @transfer.unsorted_media
    puts
    puts "unsorted_files BELOW"
    puts @transfer.unsorted_files
  end

end

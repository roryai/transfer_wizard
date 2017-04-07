require_relative 'transfer_manager.rb'

class Operator

  def initialize
    @transfer = Transfer.new
    @welcome_text = "\n\nWelcome to photo_transfer.

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

    Type 'dz' and 'enter':
      Photos & videos with & without EXIF data will be sorted into dated folders.
      All other files will be copied to the 'Unsorted Files' folder.

    Type 'mz' and 'enter':
      Photos & videos with & without EXIF data will be sorted into month and year folders.
      All other files will be copied to the 'Unsorted Files' folder.

    Type 'dx' and 'enter':
      All files will be sorted into dated folders based on EXIF data or file creation date*.

    Type 'mx' and 'enter':
      All files will be sorted into month and year folders based on EXIF data or file creation date*.

    Type 'del' and 'enter' to delete all files in 'tester' directory.

    Type 'y' and 'enter' to run current test method.
    Type 'x' or 'quit' and 'enter' to quit this program.

    *on UNIX systems, file creation date is when the file was last copied or moved. On Windows, original file creation date is maintained when a file is copied.\n"
  end

  def terminal_flag_processor
    if ARGV[0] == 'date'
      day_unsorted
    elsif ARGV[0] == 'month'
      month_unsorted
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
        function_selector
      when 'w'
        set_destination_directory
        function_selector
      when 'e'
        get_source_directory
        function_selector
      when 'r'
        get_destination_directory
        function_selector
      when 'd'
        log_header
        day_unsorted
        create_log_and_restart_function_selector
      when 'm'
        log_header
        month_unsorted
        create_log_and_restart_function_selector
      when 'dz'
        log_header
        day_media_sorted
        create_log_and_restart_function_selector
      when 'mz'
        log_header
        month_media_sorted
        create_log_and_restart_function_selector
      when 'dx'
        log_header
        day_all_sorted
        create_log_and_restart_function_selector
      when 'mx'
        log_header
        month_all_sorted
        create_log_and_restart_function_selector
      when 'del'
        delete_destination_contents
        function_selector
      when 'y'
        test_method
        function_selector
      when 'x'
        exit
      when 'quit'
        exit
      else
        puts "Please enter a valid character"
        puts "Type 'x' or 'quit' and 'enter' to quit this program."
        function_selector
    end
  end

  def set_source_directory
    puts "Type the directory in the following format, then press enter:
    /Users/rory/Documents/test_camera/"
    @transfer.source_dir = gets.chomp
    puts "\nSource directory changed to: " + @transfer.source_dir + "\n"
    @transfer.all_files_and_times = []
    @transfer.all_files_and_times = @transfer.file_mgr.get_name_time_array(@transfer.source_dir)
  end

  def set_destination_directory
    puts "Type the directory in the following format, then press enter:
    /Users/rory/Documents/tester/"
    @transfer.destination_dir = gets.chomp
    puts "\nDestination directory changed to: " + @transfer.destination_dir + "\n"
  end

  def get_source_directory
    puts "\n" + @transfer.source_dir + "\n\n"
  end

  def get_destination_directory
    puts "\n" + @transfer.destination_dir + "\n\n"
  end

  def log_header
    @transfer.log.log_text << "SOURCE: " + @transfer.source_dir
    @transfer.log.log_text << "DESTINATION: " + @transfer.destination_dir
    @transfer.log.log_text << "Transferred at : " + Time.new.to_s + "\n"
  end

  def day_unsorted
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.files_with_exif, :day, :sort)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_media, :day, :unsorted_media)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_files, :day, :unsorted_files)
  end

  def month_unsorted
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.files_with_exif, :month, :sort)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_media, :month, :unsorted_media)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_files, :month, :unsorted_files)
  end

  def day_media_sorted
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.files_with_exif, :day, :sort)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_media, :day, :sort)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_files, :day, :unsorted_files)
  end

  def month_media_sorted
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.files_with_exif, :month, :sort)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_media, :month, :sort)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_files, :month, :unsorted_files)
  end

  def day_all_sorted
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.files_with_exif, :day, :sort)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_media, :day, :sort)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_files, :day, :sort)
  end

  def month_all_sorted
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.files_with_exif, :month, :sort)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_media, :month, :sort)
    @transfer.transfer_files_to_dirs(@transfer.source_dir, @transfer.destination_dir, @transfer.unsorted_files, :month, :sort)
  end

  def delete_destination_contents
    dir = "/Users/rory/Documents/tester/"
    puts "Are you sure you want to delete all files in " + dir + "?"
    puts "Type 'y' to proceed"
    input = gets.chomp
    @transfer.dir_mgr.delete_all_in_folder(dir) if input == 'y'
  end

  def create_log_and_restart_function_selector
    puts "Total files transferred: " + @transfer.log.total_count.to_s
    @transfer.log.log_text << "Total files transferred: " + @transfer.log.total_count.to_s
    @transfer.log.create_log_file(@transfer.destination_dir)
    @transfer.log.log_text = []
    @transfer.log.total_count = 0
    function_selector
  end

  def test_method
    puts "######################################## files_with_exif BELOW #######################################"
    puts @transfer.files_with_exif
    puts
    puts "######################################## unsorted_media BELOW ########################################"
    puts @transfer.unsorted_media
    puts
    puts "######################################## unsorted_files BELOW ########################################"
    puts @transfer.unsorted_files
    puts
    puts "Amount of files in files_with_exif: " + @transfer.files_with_exif.length.to_s
    puts
    puts "Amount of files in unsorted_media: " + @transfer.unsorted_media.length.to_s
    puts
    puts "Amount of files in unsorted_files: " + @transfer.unsorted_files.length.to_s
    puts
    puts "Total amount of files: " + (@transfer.files_with_exif.length + @transfer.unsorted_media.length + @transfer.unsorted_files.length).to_s
  end

end

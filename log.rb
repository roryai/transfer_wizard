class Log

  attr_accessor :log_text, :transferred_count

  def initialize
    @prefix = "LOG "
    @extension = ".txt"
    @log_text = []
    @transferred_count = 0
    @time = Time.new
  end

  def create_log_file(target_dir)
    log_name = unique_name_checker(target_dir)
    # writes each line in the log array to the log file
    File.open(target_dir + log_name, 'a') { |file| @log_text.each { |line| file.write(line + "\n") }}
  end

  def unique_name_checker(target_dir)
    log_name = create_log_name
    FileUtils.cd(target_dir)
    unique_name_creator(log_name)
  end

  def unique_name_creator(log_name)
    if File.exist?(@prefix + log_name + @extension)
      return @prefix + log_name + "-" + @time.sec.to_s + @extension
    else
      return @prefix + log_name + @extension
    end
  end

  def create_log_name
    @time.year.to_s + "-" + @time.month.to_s + "-" + @time.day.to_s + "@" + @time.hour.to_s + "-" + @time.min.to_s
  end

  def counter_output(file_name_time_array)
    puts to_be_transferred_counter(file_name_time_array)
    puts transferred_counter
    @log_text << to_be_transferred_counter(file_name_time_array)
    @log_text << transferred_counter
    @transferred_count = 0
  end

  def to_be_transferred_counter(file_name_time_array)
    "Photos on camera: " + file_name_time_array.length.to_s
  end

  def transferred_counter
    "Photos transferred: " + @transferred_count.to_s
  end

end

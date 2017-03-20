require 'FileUtils'
require 'exifr'

module DirMgr

  def make_directory(dir_to_make_within, dir_to_make)
    FileUtils.cd(dir_to_make_within)
    create_or_skip(dir_to_make)
  end

  def create_or_skip(dir_to_make)
    if Dir.exist?(dir_to_make)
      puts "Directory already exists: " + (" " * 3) + dir_to_make
    else
      FileUtils.mkdir(dir_to_make)
      puts "Directory created: " + (" " * 10) + dir_to_make
    end
  end

  def create_dir_by_day_or_month(file_name_time_array, computer_dir, day_or_month)
    file_name_time_array.each do |file_name, time|
      if day_or_month == "day"
        make_directory(computer_dir, folder_name_generator(day_or_month, time))
      elsif day_or_month == "month"
        make_directory(computer_dir, time.year.to_s)
        make_directory(computer_dir + time.year.to_s, folder_name_generator("month", time))
      end
    end
  end

  def folder_name_generator(day_or_month, time)
    if day_or_month == "month"
      return make_folder_name_month(time)
    elsif day_or_month == "day"
      return make_folder_name_day(time)
      # put error here if wrong param passed
    end
  end

  def make_folder_name_month(time)
    month_array = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
    month_array[time.month - 1]
  end

  def make_folder_name_day(time)
    time.year.to_s + "-" + time.month.to_s + "-" + time.day.to_s
  end

end

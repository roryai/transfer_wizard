require 'FileUtils'
require 'exifr'

class DirMgr

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
        make_directory(computer_dir, folder_name_generator(time, day_or_month))
      elsif day_or_month == "month"
        make_directory(computer_dir, time.year.to_s)
        make_directory(computer_dir + time.year.to_s, folder_name_generator(time, "month"))
      end
    end
  end

  def folder_name_generator(time, day_or_month)
    if day_or_month == "month"
      return make_folder_name_month(time)
    elsif day_or_month == "day"
      return make_folder_name_day(time)
      # put error here if wrong param passed
    end
  end

  def make_folder_name_month(time)
    month_array = ['01-January', '02-February', '03-March', '04-April', '05-May', '06-June', '07-July', '08-August', '09-September', '10-October', '11-November', '12-December']
    month_array[time.month - 1]
  end

  def make_folder_name_day(time)
    time.year.to_s + "-" + time.month.to_s + "-" + time.day.to_s
  end

  def delete_all_in_folder(dir)
    p "Deleting all in " + dir
    FileUtils.cd(dir)
    file_name_array = Dir.glob("*")
    file_name_array.each do |file|
      puts "Deleting #{file.to_s}"
      FileUtils.rm_r(file)
    end
  end

end

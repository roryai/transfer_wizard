require 'FileUtils'
require 'exifr'
require_relative 'directory_manager.rb'
require_relative 'file_manager.rb'
require_relative 'log.rb'

class Transfer
  extend DirMgr
  extend FileMgr
  attr_accessor :camera_dir, :computer_dir

  def initialize
    @camera_dir ||= "/Users/rory/Documents/legacy_photos"
    @computer_dir ||= "/Users/rory/Documents/tester/"
    @file_name_time_array = Transfer.get_name_time_array(@camera_dir)
    @no_exifr_array = []
    @log = Log.new
    @rjust = 45
  end

  def single_photo_transfer(copy_from, copy_to, file_name, target_dir)
    if File.exist?(file_name)
      file_exists(file_name, target_dir)
    else
      transfer_file(copy_from, copy_to, file_name, target_dir)
    end
  end

  def file_exists(file_name, target_dir)
    already_exists = " file exists in: ".rjust(@rjust-file_name.length)
    @log.log_text << file_name + already_exists + target_dir
    puts file_name + already_exists + target_dir
  end

  def transfer_file(copy_from, copy_to, file_name, target_dir)
    transferred_to = " transferred to: ".rjust(@rjust-file_name.length)
    copy_file(copy_from, copy_to)
    @log.log_text << file_name + transferred_to + target_dir
    puts file_name + transferred_to + target_dir
    @log.transferred_count += 1
  end

  def copy_file(copy_from, copy_to)
    FileUtils.copy_file(copy_from, copy_to, preserve = false, dereference = true)
  end

  def multiple_photo_transfer(copy_from, copy_to, day_or_month)
    @file_name_time_array.each do |file_name, time|
      target_dir = set_target_dir(copy_to, day_or_month, time)
      FileUtils.cd(target_dir)
      single_photo_transfer(copy_from + "/" + file_name, target_dir + "/" + file_name, file_name, target_dir)
    end
  end

  def set_target_dir(copy_to, day_or_month, time)
    if day_or_month == "month"
      return copy_to + time.year.to_s + "/" + (Transfer.folder_name_generator("month", time))
    elsif day_or_month == "day"
      return copy_to + (Transfer.folder_name_generator(day_or_month, time))
    end
  end

  def transfer_photos_to_directories(day_or_month)
    Transfer.create_dir_by_day_or_month(@file_name_time_array, @computer_dir, day_or_month)
    multiple_photo_transfer(@camera_dir, @computer_dir, day_or_month)
    @log.counter_output(@file_name_time_array)
    @log.create_log_file(@computer_dir)
  end


end

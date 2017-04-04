require 'FileUtils'
require 'exifr'
require_relative 'directory_manager.rb'
require_relative 'file_manager.rb'
require_relative 'log.rb'

class Transfer
  attr_accessor :camera_dir, :computer_dir, :dir_mgr, :log, :files_with_exif, :unsorted_media, :unsorted_files

  def initialize
    @camera_dir ||= "/Users/rory/Documents/legacy_photos"
    @computer_dir ||= "/Users/rory/Documents/tester/"
    @file_mgr = FileMgr.new
    @dir_mgr = DirMgr.new
    @log = Log.new
    @all_files_and_times = @file_mgr.get_name_time_array(@camera_dir)
    @files_with_exif = @all_files_and_times[0]
    @unsorted_media = @all_files_and_times[1]
    @unsorted_files = @all_files_and_times[2]
    @rjust = 48
  end

  def transfer_photos_to_directories(source, destination, files, day_or_month, sort_status)
    @dir_mgr.create_dir_by_day_or_month(files, destination, day_or_month, sort_status)
    # insert method here that transfers @unsorted_media to 'Unsorted' directories?
    @log.log_text << "START\n"
    multiple_photo_transfer(source, destination, files, day_or_month, sort_status)
    @log.counter_output(files, day_or_month, sort_status)
  end

  def multiple_photo_transfer(copy_from, copy_to, files, day_or_month, sort_status)
    files.each do |file_name, time, full_file_path, file_dir|
      target_dir = set_target_dir(copy_to, time, day_or_month, sort_status)
      FileUtils.cd(target_dir)
      single_photo_transfer(full_file_path, file_name, target_dir)
    end
  end

  def set_target_dir(copy_to, time, day_or_month, sort_status)
    if sort_status == :unsorted_media
      return copy_to + "Unsorted Media"
    elsif sort_status == :unsorted_files
      return copy_to + "Unsorted Files"
    elsif day_or_month == :month
      return copy_to + time.year.to_s + "/" + (@dir_mgr.folder_name_generator(time, :month))
    elsif day_or_month == :day
      return copy_to + (@dir_mgr.folder_name_generator(time, day_or_month))
    end
  end

  def single_photo_transfer(copy_from, file_name, target_dir)
    if File.exist?(file_name)
      file_exists(file_name, target_dir)
    else
      transfer_file(copy_from, file_name, target_dir)
    end
  end

  def file_exists(file_name, target_dir)
    already_exists = " file exists in: ".rjust(@rjust-file_name.length)
    @log.log_text << file_name + already_exists + target_dir
    puts file_name + already_exists + target_dir
  end

  def transfer_file(copy_from, file_name, target_dir)
    transferred_to = " transferred to: ".rjust(@rjust-file_name.length)
    copy_file(copy_from, target_dir + "/" + file_name)
    @log.log_text << file_name + transferred_to + target_dir
    puts file_name + transferred_to + target_dir
    @log.transferred_count += 1
  end

  def copy_file(copy_from, copy_to)
    FileUtils.copy_file(copy_from, copy_to, preserve = false, dereference = true)
  end
end

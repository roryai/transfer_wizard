require 'FileUtils'
require 'exifr'
require_relative 'directory_manager.rb'
require_relative 'file_manager.rb'
require_relative 'log.rb'

class Transfer
  attr_accessor :source_dir, :destination_dir, :file_mgr, :dir_mgr, :log, :all_files_and_times, :files_with_exif, :unsorted_media, :unsorted_files

  def initialize
    @source_dir = "C:/organised_photos/hard drive to sort"
    # @destination_dir must have forward slash on the end
    @destination_dir = "C:/organised_photos/"
    # "C:/organised_photos/"
    @file_mgr = FileMgr.new
    @dir_mgr = DirMgr.new
    @log = Log.new
    @all_files_and_times = @file_mgr.get_name_time_array(@source_dir)
    @files_with_exif = @all_files_and_times[0]
    @unsorted_media = @all_files_and_times[1]
    @unsorted_files = @all_files_and_times[2]
    @rjust = 48
  end

  def transfer_files_to_dirs(source_dir, destination_dir, files, day_or_month, sort_status)
    @dir_mgr.create_dir_by_day_or_month(files, destination_dir, day_or_month, sort_status)
    @log.log_text << "START\n"
    multiple_file_transfer(source_dir, destination_dir, files, day_or_month, sort_status)
    @log.counter_output(files, day_or_month, sort_status)
  end

  def multiple_file_transfer(copy_from, copy_to, files, day_or_month, sort_status)
    files.each do |file_name, time, full_file_path, file_dir|
      target_dir = set_target_dir(copy_to, time, day_or_month, sort_status)
      FileUtils.cd(target_dir)
      single_file_transfer(full_file_path, file_name, target_dir)
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

  # refactor
  def single_file_transfer(full_file_path, file_name, target_dir)
    if !File.exist?(file_name)
      transfer_file(full_file_path, file_name, target_dir)
    elsif File.exist?(file_name)
      if same_size?(full_file_path, file_name, target_dir) == true
        file_exists(file_name, target_dir)
      else
        file_name = "(name_conflict)" + file_name
        transfer_file(full_file_path, file_name, target_dir)
      end
    end
  end

  # refactor
  def same_size?(full_file_path, file_name, target_dir)
    file_to_be_copied = full_file_path
    file_in_destination = target_dir + "/" + file_name
    file_to_be_copied_size = File.size(file_to_be_copied).abs
    file_in_destination_size = File.size(file_in_destination).abs
    if file_to_be_copied_size == file_in_destination_size
      return true
    else
      return false
    end
  end

  def file_exists(file_name, target_dir)
    already_exists = " file exists in: ".rjust(@rjust-file_name.length)
    @log.log_text << file_name + already_exists + target_dir
    puts file_name + already_exists + target_dir
  end

  def transfer_file(full_file_path, file_name, target_dir)
    transferred_to = " transferred to: ".rjust(@rjust-file_name.length)
    copy_file(full_file_path, target_dir, file_name, transferred_to)
    @log.log_text << file_name + transferred_to + target_dir
    @log.transferred_count += 1
  end

  def copy_file(full_file_path, target_dir, file_name, transferred_to)
    copy_to = target_dir + "/" + file_name
    FileUtils.copy_file(full_file_path, copy_to, preserve = false, dereference = true)
    puts file_name + transferred_to + target_dir
  end
end

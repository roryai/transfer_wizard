require 'FileUtils'
require 'exifr'
require_relative 'directory_manager.rb'
require_relative 'file_manager.rb'

class Transfer
  extend DirMgr
  extend FileMgr

  attr_reader :camera_dir, :computer_dir, :file_name_array, :exifr_time_array, :file_name_time_array

  def initialize
    @camera_dir = "/Volumes/Untitled/test/"
    @computer_dir = "/Users/rory/Documents/tester/"
    @file_name_array = Transfer.get_file_names(@camera_dir)
    @exifr_time_array = Transfer.get_exifr_time_array(@file_name_array)
    @file_name_time_array = Transfer.get_name_time_array(@file_name_array)
  end

  def single_photo_transfer(copy_from, copy_to)
    FileUtils.copy_file(copy_from, copy_to, preserve = false, dereference = true)
  end

  def copy_all_photos(camera_dir, computer_dir)
    @file_name_array.each do |file_name|
      single_photo_transfer(camera_dir + "#{file_name}", computer_dir + "#{file_name}")
    end
  end

  def transfer_photos_to_dated_directories
    Transfer.create_dir_by_date_taken(@exifr_time_array, @computer_dir)
    @file_name_time_array.each do |file_name, time|
      target_dir = @computer_dir + (Transfer.get_folder_name(time))
      FileUtils.cd(target_dir)
      single_photo_transfer(@camera_dir + "/" + file_name, target_dir + "/" + file_name)
    end
  end

end

a = Transfer.new
a.transfer_photos_to_dated_directories

# copy_all_photos(@camera_dir, @computer_dir)

# create_dir_by_date_taken(@exifr_time_array, @computer_dir)

# get_exifr_time_array(get_file_names(CAMERA_DIR))

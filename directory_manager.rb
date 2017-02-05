require 'FileUtils'
require 'exifr'
require_relative 'file_manager.rb'
require_relative 'photo_transfer.rb'

module DirMgr

  def make_directory(dir_to_make_within, dir_to_make)
    FileUtils.cd(dir_to_make_within)
    FileUtils.mkdir(dir_to_make)
  end

  def folder_name(time)
    time.year.to_s + "-" + time.month.to_s + "-" + time.day.to_s
  end

  def create_dir_by_date_taken(times_array, computer_dir)
    arr = times_array
    arr.each do |x|
      make_directory(computer_dir, folder_name(x)) unless File.exist?(folder_name(x))
    end
    arr
  end

end

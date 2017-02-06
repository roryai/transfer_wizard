require 'FileUtils'
require 'exifr'

module DirMgr

  def make_directory(dir_to_make_within, dir_to_make)
    FileUtils.cd(dir_to_make_within)
    FileUtils.mkdir(dir_to_make)
  end

  def get_folder_name(time)
    time.year.to_s + "-" + time.month.to_s + "-" + time.day.to_s
  end

  def create_dir_by_date_taken(times_array, computer_dir)
    times_array.each do |x|
      make_directory(computer_dir, get_folder_name(x)) unless File.exist?(get_folder_name(x))
    end
  end

end

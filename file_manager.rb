require 'FileUtils'
require 'exifr'
require_relative 'directory_manager.rb'
require_relative 'photo_transfer.rb'

module FileMgr

  def get_file_names(dir)
    FileUtils.cd(dir)
    file_name_array = Dir.glob("*") #possibly delete file_name_array
  end

  def get_exifr_time_array(file_names)
    arr = []
    arr.each do |x|
      arr << EXIFR::JPEG.new(x).date_time
    end
    arr
  end

end

require 'FileUtils'
require 'exifr'
# require_relative 'directory_manager.rb'
# require_relative 'photo_transfer.rb'

module FileMgr

  def get_file_names(dir)
    FileUtils.cd(dir)
    file_name_array = Dir.glob("*") #possibly delete file_name_array
  end

  def get_exifr_time_array(file_names)
    arr = []
    file_names.each do |x|
      arr << EXIFR::JPEG.new(x).date_time
    end
    arr
  end

  def get_name_time_array(arr)
    combined_arr = []
    arr.each do |x|
      combined_arr << [x, EXIFR::JPEG.new(x).date_time]
    end
    combined_arr
  end

end

# p x
# temp_arr << x
# p temp_arr
# temp_arr << EXIFR::JPEG.new(x).date_time
# p temp_arr
# final_arr << temp_arr

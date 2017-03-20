require 'FileUtils'
require 'exifr'

module FileMgr

  def get_file_names(dir)
    FileUtils.cd(dir)
    # line below could cause problems with small files- size limit? Grab by extension?
    file_name_array = Dir.glob("*")
  end

  def get_name_time_array(camera_dir)
    file_name_array = get_file_names(camera_dir)
    file_name_time_array = []
    file_name_array.each do |file_name|
      file_name_time_array << [file_name, EXIFR::JPEG.new(file_name).date_time]
    end
    file_name_time_array
  end

end

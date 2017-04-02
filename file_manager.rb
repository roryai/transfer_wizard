require 'FileUtils'
require 'exifr'

class FileMgr

  def initialize
    @file_name_time_array = []
  end

  def get_file_names(dir)
    FileUtils.cd(dir)
    # line below could cause problems with small files- size limit? Grab by extension?
    file_name_array = Dir.glob("*")
  end

  def get_name_time_array(camera_dir)
    file_name_array = get_file_names(camera_dir)


    file_name_array.each do |file_name|
       p file_name
        begin
          @file_name_time_array << [file_name, EXIFR::JPEG.new(file_name).date_time]
          # if file_name has no EXIF data
        rescue EXIFR::MalformedJPEG
          @file_name_time_array << [file_name, File.ctime(file_name)]
          # if file_name is a directory
        rescue Errno::EISDIR
          p "current directory below"
          p FileUtils.pwd() + "/" + file_name
          get_name_time_array(FileUtils.pwd() + "/" + file_name)
        end
    end

    @file_name_time_array
  end

end

# EXIFR::JPEG.new(file_name).date_time File.ctime(file_name)

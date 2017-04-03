require 'FileUtils'
require 'exifr'

class FileMgr

  def initialize
    @file_name_time_array = []
    @no_exifr_array = []
  end

  def get_file_names(dir)
    FileUtils.cd(dir)
    # line below could cause problems with small files- size limit? Grab by extension?
    file_name_array = Dir.glob("*")
  end

  def get_name_time_array(camera_dir)
    file_name_array = get_file_names(camera_dir)
    # p "file name array at start" + file_name_array.to_s

    file_name_array.each do |file_name|
        begin
          if EXIFR::JPEG.new(file_name).date_time == nil
            p "asd"
            p "dir name"
            p File.dirname(file_name)
            p FileUtils.pwd
            p file_name
            @no_exifr_array << file_name
          else
            p "zcv"
            @file_name_time_array << [file_name, EXIFR::JPEG.new(file_name).date_time, FileUtils.pwd + "/" + file_name, FileUtils.pwd]
          end
          # if file_name has no EXIF data
        rescue EXIFR::MalformedJPEG
          p 'mal jpeg'
          @file_name_time_array << [file_name, File.ctime(file_name)]
          # if file_name is a directory
        rescue Errno::EISDIR
          p 'eisdir'
          get_name_time_array(FileUtils.pwd + "/" + file_name)
          file_name_array = []
        end
    end
    [@file_name_time_array, @no_exifr_array]
  end

end

# EXIFR::JPEG.new(file_name).date_time File.ctime(file_name)

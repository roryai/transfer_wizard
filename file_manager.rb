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
      p "pwd: " + FileUtils.pwd
        begin
          if EXIFR::JPEG.new(file_name).date_time == nil
            p "no exifr section"
            full_file_path = FileUtils.pwd + "/" + file_name
            file_dir = FileUtils.pwd
            @no_exifr_array << [file_name, "no_time_stamp", full_file_path, file_dir]
            p file_name + ' added'
          else
            p "exifr section"
            p "exif time: " + (time = EXIFR::JPEG.new(file_name).date_time).to_s
            p "ctime: " + (time = File.ctime(file_name)).to_s
            time = EXIFR::JPEG.new(file_name).date_time
            full_file_path = FileUtils.pwd + "/" + file_name
            file_dir = FileUtils.pwd
            @file_name_time_array << [file_name, time, full_file_path, file_dir]
            p file_name + ' added'
          end
          # if file_name has no EXIF data
        rescue EXIFR::MalformedJPEG
          p 'malformed jpeg'
          time = File.ctime(file_name)
          full_file_path = FileUtils.pwd + "/" + file_name
          file_dir = FileUtils.pwd
          @file_name_time_array << [file_name, time, full_file_path, file_dir]
          p file_name + ' added'
          # if file_name is a directory
        rescue Errno::EISDIR
          p "eisdir- it's a directory error"
          FileUtils.cd(camera_dir + "/" + file_name) do
            get_name_time_array(FileUtils.pwd)
          end
        rescue Errno::ENOENT
          p "ERRNOENT rescued"
        end
    end
    [@file_name_time_array, @no_exifr_array]
  end

end

require 'FileUtils'
require 'exifr'

class FileMgr

  def initialize
    @files_with_exif = []
    @unsorted_media = []
    @unsorted_files = []
    @pic_extensions = ['.bmp', '.gif', '.jpg', '.jpeg', '.png', '.tif', '.tiff', '.BMP', '.GIF', '.JPG', '.JPEG', '.PNG', '.TIF', '.TIFF', ]
    @vid_extensions = ['.3g2', '.3gp', '.asf', '.asx', '.avi', '.m4v', '.mov', '.mp4', '.mpg', '.rm', '.wmv', '.3G2', '.3GP', '.ASF', '.ASX', '.AVI', '.M4V', '.MOV', '.MP4', '.MPG', '.RM', '.WMV']
  end

  def get_file_names(dir)
    FileUtils.cd(dir)
    file_name_array = Dir.glob("*")
  end

  def get_name_time_array(dir)
    get_file_names(dir).each do |file_name|
      time = File.ctime(file_name)
      full_file_path = FileUtils.pwd + "/" + file_name
      file_dir = FileUtils.pwd
      file_type_sorter(file_name, time, full_file_path, file_dir, dir)
    end
    [@files_with_exif, @unsorted_media, @unsorted_files]
  end

  def file_type_sorter(file_name, time, full_file_path, file_dir, dir)
    if @pic_extensions.include?(File.extname(file_name)) || @vid_extensions.include?(File.extname(file_name))
      pic_and_vid_handler(file_name, time, full_file_path, file_dir)
    elsif File.directory?(file_name)
      recursive_directory_handler(dir, file_name)
    else
      @unsorted_files << [file_name, time, full_file_path, file_dir]
    end
  end

  def pic_and_vid_handler(file_name, time, full_file_path, file_dir)
    begin
      exif_handler(file_name, time, full_file_path, file_dir)
    rescue EXIFR::MalformedJPEG
      @unsorted_media << [file_name, time, full_file_path, file_dir]
    end
  end

  def exif_handler(file_name, time, full_file_path, file_dir)
    if EXIFR::JPEG.new(file_name).date_time == nil
      @unsorted_media << [file_name, time, full_file_path, file_dir]
    else
      time = EXIFR::JPEG.new(file_name).date_time
      @files_with_exif << [file_name, time, full_file_path, file_dir]
    end
  end

  def recursive_directory_handler(dir, file_name)
    FileUtils.cd(dir + "/" + file_name) do
      get_name_time_array(FileUtils.pwd)
    end
  end

end

require 'FileUtils'
require 'exifr'

class FileMgr

  def initialize
    @file_name_time_array = []
    @unsorted_pics_and_vids = []
    @unsorted_files = []
    @pic_extensions = ['.bmp', '.gif', '.jpg', '.jpeg', '.png', '.tif', '.tiff', '.BMP', '.GIF', '.JPG', '.JPEG', '.PNG', '.TIF', '.TIFF', ]
    @vid_extensions = ['.3g2', '.3gp', '.asf', '.asx', '.avi', '.m4v', '.mov', '.mp4', '.mpg', '.rm', '.wmv', '.3G2', '.3GP', '.ASF', '.ASX', '.AVI', '.M4V', '.MOV', '.MP4', '.MPG', '.RM', '.WMV']
  end

  def get_file_names(dir)
    FileUtils.cd(dir)
    # line below could cause problems with small files- size limit? Grab by extension?
    file_name_array = Dir.glob("*")
  end

  def get_name_time_array(dir)
    file_name_array = get_file_names(dir)

    file_name_array.each do |file_name|
      full_file_path = FileUtils.pwd + "/" + file_name
      file_dir = FileUtils.pwd



          if @pic_extensions.include?(File.extname(file_name)) || @vid_extensions.include?(File.extname(file_name))
            begin
              if EXIFR::JPEG.new(file_name).date_time == nil
                time = File.ctime(file_name)
                @unsorted_pics_and_vids << [file_name, time, full_file_path, file_dir]
              else
                time = EXIFR::JPEG.new(file_name).date_time
                @file_name_time_array << [file_name, time, full_file_path, file_dir]
              end
            rescue EXIFR::MalformedJPEG
              p 'malformed jpeg'
              p file_name
              time = File.ctime(file_name)
              @unsorted_pics_and_vids << [file_name, time, full_file_path, file_dir]
            # if file_name is a directory
            end
          elsif File.directory?(file_name)
            FileUtils.cd(dir + "/" + file_name) do
              get_name_time_array(FileUtils.pwd)
            end
          else
            time = File.ctime(file_name)
            @unsorted_files << [file_name, time, full_file_path, file_dir]
          end
        # # if file_name has no EXIF data
        # # redundant?

        # rescue Errno::EISDIR
        #   p "eisdir- it's a directory error"
        #   FileUtils.cd(dir + "/" + file_name) do
        #     get_name_time_array(FileUtils.pwd)
        #   end
        # rescue Errno::ENOENT
        #   p "ERRNOENT rescued for file: " + file_name

    end
    [@file_name_time_array, @unsorted_pics_and_vids, @unsorted_files]
  end

end

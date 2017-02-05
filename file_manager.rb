class FileManager

  def get_file_names(dir)
    FileUtils.cd(dir)
    file_name_array = Dir.glob("*")
  end

  def get_exifr_time_array(file_names)
    arr = []
    file_names.each do |x|
      arr << EXIFR::JPEG.new(x).date_time
    end
    arr
  end

end

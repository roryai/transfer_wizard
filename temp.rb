begin
          # insert file extension filter here- only allow pics and vids through.
          # do 'exifr section' first, then 'no exifr section'.
          # send all other files to 'no exifr section'.
          if EXIFR::JPEG.new(file_name).date_time == nil
            p "no exifr section"
            full_file_path = FileUtils.pwd + "/" + file_name
            file_dir = FileUtils.pwd
            @unsorted_media << [file_name, "no_time_stamp", full_file_path, file_dir]
            p file_name + ' added'
          else
            p "exifr section"
            p "exif time: " + (time = EXIFR::JPEG.new(file_name).date_time).to_s
            p "ctime: " + (time = File.ctime(file_name)).to_s
            time = EXIFR::JPEG.new(file_name).date_time
            full_file_path = FileUtils.pwd + "/" + file_name
            file_dir = FileUtils.pwd
            @files_with_exif << [file_name, time, full_file_path, file_dir]
            p file_name + ' added'
          end
          # if file_name has no EXIF data
        rescue EXIFR::MalformedJPEG
          p 'malformed jpeg'
          time = File.ctime(file_name)
          full_file_path = FileUtils.pwd + "/" + file_name
          file_dir = FileUtils.pwd
          @files_with_exif << [file_name, time, full_file_path, file_dir]
          p file_name + ' added'
          # if file_name is a directory
        rescue Errno::EISDIR
          p "eisdir- it's a directory error"
          FileUtils.cd(source_dir + "/" + file_name) do
            get_name_time_array(FileUtils.pwd)
          end
        rescue Errno::ENOENT
          p "ERRNOENT rescued"
end

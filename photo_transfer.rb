require 'FileUtils'

def get_file_names(dir)
  FileUtils.cd(dir)
  file_name_array = Dir.glob("*")
end

def single_photo_transfer(copy_from, copy_to)
  FileUtils.copy_file(copy_from, copy_to, preserve = false, dereference = true)
end

def copy_all_photos
  photo_list = get_file_names("/Volumes/Untitled/test")
  photo_list.each do |x|
    single_photo_transfer("/Volumes/Untitled/test/#{x}", "/Users/rory/Documents/tester/#{x}")
  end
end

copy_all_photos

require 'FileUtils'

camera_dir = "/Volumes/Untitled/test/"
computer_dir = "/Users/rory/Documents/tester/"

def get_file_names(dir)
  FileUtils.cd(dir)
  file_name_array = Dir.glob("*")
end

def single_photo_transfer(copy_from, copy_to)
  FileUtils.copy_file(copy_from, copy_to, preserve = false, dereference = true)
end

def copy_all_photos(camera_dir, computer_dir)
  photo_list = get_file_names(camera_dir)
  photo_list.each do |file_name|
    single_photo_transfer(camera_dir + "#{file_name}", computer_dir + "#{file_name}")
  end
end

copy_all_photos(camera_dir, computer_dir)

require 'FileUtils'

def single_photo_transfer
  FileUtils.copy_file('/Volumes/Untitled/test/photo3.JPG', '/Users/rory/Documents/tester/photo3.JPG', preserve = false, dereference = true)
end

def get_file_names(dir)
  FileUtils.cd(dir)
  file_name_array = Dir.glob("*")
end

def print_file_names(dir)
  puts get_file_names(dir)
end

print_file_names('/Users/rory/Documents/tester')

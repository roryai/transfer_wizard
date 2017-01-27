require 'FileUtils'

def single_photo_transfer
  FileUtils.copy_file('/Volumes/Untitled/test/photo3.JPG', '/Users/rory/Documents/tester/photo3.JPG', preserve = false, dereference = true)
end

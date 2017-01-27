require 'FileUtils'

def single_photo_transfer
  FileUtils.move '/Volumes/Untitled/test/photo2.JPG', '/Users/rory/Documents/tester'
end

single_photo_transfer


#photo on sd card: /Volumes/Untitled/test/photo1.JPG
#photo folder on hard drive /Volumes/Untitled/test/photo1.JPG /Users/rory/Documents/Photo\ test

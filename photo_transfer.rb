require 'FileUtils'
require 'exifr'

@camera_dir = "/Volumes/Untitled/test/"
@computer_dir = "/Users/rory/Documents/tester/"

def get_file_names(dir)
  FileUtils.cd(dir)
  file_name_array = Dir.glob("*")
end

@file_name_array = get_file_names(@camera_dir)

def single_photo_transfer(copy_from, copy_to)
  FileUtils.copy_file(copy_from, copy_to, preserve = false, dereference = true)
end

def copy_all_photos(camera_dir, computer_dir)
  photo_list = get_file_names(camera_dir)
  photo_list.each do |file_name|
    single_photo_transfer(camera_dir + "#{file_name}", computer_dir + "#{file_name}")
  end
end

def make_directory(dir_to_make_within, dir_to_make)
  FileUtils.cd(dir_to_make_within)
  FileUtils.mkdir(dir_to_make)
end

def folder_name_by_date
  t = Time.now
  t.year.to_s + "-" + t.month.to_s + "-" + t.day.to_s
end

def folder_name_from_metadata
  EXIFR::JPEG.new('IMG_6841.JPG').date_time
end


def test_metadata
  @file_name_array.each do |x|
    p EXIFR::JPEG.new(x).date_time
  end
end

# make_directory(computer_dir, folder_name_by_date)
# copy_all_photos(camera_dir, computer_dir)
test_metadata

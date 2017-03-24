### A program that transfers photos from a camera connected via USB.



Current features:

Transfers photos into folders generated from EXIF data of photo by date or month + year taken.

Allows copy from and copy to directories to be set via terminal.

Produces a log file giving details of all photos selected for transfer. Shows whether they are transferred or whether they already exist, like so:

> Directory already exists:    2008-2-5

>Directory created:           2016-12-4

>Directory already exists:    2016-12-4

>Directory already exists:    2016-12-29

>IMG_0326.JPG                 file exists in: /Users/rory/Documents/tester/2008-2-5

>photo1.JPG                   transferred to: /Users/rory/Documents/tester/2016-12-4

>photo2.JPG                   transferred to: /Users/rory/Documents/tester/2016-12-4

>photo4.JPG                   file exists in: /Users/rory/Documents/tester/2016-12-29

>Photos on camera: 4

>Photos transferred: 2


I am creating this to practice building software that interacts with my file system and had a real world application. Eventually it will replace the default Sony software that has hundreds of features that I don't use, and is missing a couple that I would like.

The commit history from 7th February to 21st March disappeared when I copied my local files to another directory.

# USER STORIES

As a user

So that I can backup my photos

I want to transfer all photos on my camera to my hard drive


As a user

So that I can find my photos easily

I want to transfer photos into folders that are named for the date the photo was taken



As a user

So that I don't duplicate photos

I only want to transfer photos that have not already been transferred



As a user

For ease of use

I want to be able to run the program from my terminal





As a user

For more control over my program

I want to be able to be able to control the following via command line flags:



Transfer all

Transfer new

Transfer with delete

Destination directory



As a user

So that I can make space available on my camera

I want to delete photos from my SD card once they have been transferred



As a user

So that I don't accidentally lose my photos

I want to confirm that photos have been transferred before I delete them

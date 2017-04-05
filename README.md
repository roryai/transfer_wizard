## A program that transfers files and organises them into folders by date or month.

To run the program, navigate to the directory containing 'transfer_wizard.rb' and run the following command:


`ruby transfer_wizard.rb`


The program can be operated with command line flags, bypassing the need to use the menu.


To perform the following function:


Photos & videos with EXIF data will be sorted into dated folders.
Photos & videos without EXIF data will be copied to the 'Unsorted Media' folder.
All other files will be copied to the 'Unsorted Files' folder.


Run the following:


`ruby transfer_wizard.rb dated`


To perform the following function:


Photos & videos with EXIF data will be sorted into month and year folders.
Photos & videos without EXIF data will be copied to the 'Unsorted Media' folder.
All other files will be copied to the 'Unsorted Files' folder.


Run the following:


`ruby transfer_wizard.rb month`


NB: you will need to edit the variables '@source_dir' and '@destination_dir' in the file 'transfer_manager.rb' before running the program like this. These variables can be changed in the command line interface if you run the program without command line flags.



Originally designed to take photos from a camera and sort them into directories on a hard drive, the program now deals with all file types and can be used as a file system reorganisation tool.

If you have one or more unorganised set of photos or files on a hard drive this program will organise them into directories the day or month in which they were created. It can then be used to transfer photos from your camera, so that all past and current photos can be organised in the same place.


Photos and videos are sorted according to EXIF data, if it exists. If there is no EXIF data they are sorted by file creation time. All other file types are sorted by file creation time.


The program can be set to sort files into different folders: files with EXIF can be sorted into day or month directories, with other media going to an 'Unsorted Media' directory, and all other files going to an 'Unsorted Files' directory.


Alternatively, all photos & videos can be sorted into dated or month folders, with all other files going into the 'Unsorted Files' directory.


Lastly, all files can be sorted into date or month folders.


The program generates directory names according to the time stamp of a file.

NB: on UNIX systems, file creation date is when the file was last copied or moved. On Windows, original file creation date is maintained when a file is copied. The program is therefore less useful for reorganising old repositories of files on UNIX systems that may have been moved or copied since their original creation date. The program works well for old sets of files on Windows systems, and for all new/uncopied files on Windows or UNIX systems.


A log is generated showing the information below:

>SOURCE: /Users/rory/Documents/test_camera
>
>DESTINATION: /Users/rory/Documents/tester/
>
>Transferred at :2017-04-05 11:39:48 +0100
>
>
>START
>
>
>IMG_0326.JPG                    transferred to: /Users/rory/Documents/tester/2008-2-5
>
>photo1.JPG                      transferred to: /Users/rory/Documents/tester/2016-12-4
>
>photo2.JPG                      transferred to: /Users/rory/Documents/tester/2016-12-4
>
>photo4.JPG                      transferred to: /Users/rory/Documents/tester/2016-12-29
>
>
>END
>
>Files in source directory: 4
>
>Files transferred: 4
>
>FLAGS: Day or month: day, Sort status: sort


NB: The commit history from 7th February to 21st March disappeared when I copied my local files to another directory.

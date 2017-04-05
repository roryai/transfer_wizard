## A program that transfers files and organises them into folders by date or month.

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


photo_transfer.rb is the file that you run to start the program.


operator.rb contains the Operator class, which controls the flow of actions.


transfer_manager.rb contains the Transfer class, which handles transfers and instantiates all other classes and includes the FileMgr and DirMgr classes.


The commit history from 7th February to 21st March disappeared when I copied my local files to another directory.

## Pluralscript.rb - A youtube-dl plugin for Pluralsight

### Dependencies 
* [youtube-dl](https://github.com/ytdl-org/youtube-dl)
* python3
* ruby

### Installation
Clone youtube-dl and pluralscript

`git clone https://github.com/ytdl-org/youtube-dl.git`

`git clone https://github.com/Taikon/pluralscript.git`

### Instructions
1. Move pluralscript.rb to wherever folder you want the videos to be downloaded into
2. Replace `example_video_file.txt` contents with URL and a hash of the number of clips in each module.
3. Lets say you have a video series with 3 modules. The first module has 3 video clips, the second has 5 and the third has 2. The array should look like this [3, 5, 2]
4. You need to find the base url of the videos. Check the `example_video_file.txt` for what this looks like.
5. Run the script with `ruby pluralscript.rb`

### Supported Platforms
* Ubuntu 20.04 will work by default
* Ubuntu <20.04 will require you to edit the file path for python3

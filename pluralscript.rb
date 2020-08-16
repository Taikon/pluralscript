###Pluralscript.rb

# Example of video_url_hash. To be replaced by .txt file contents.
video_url_hash = {
  "https://app.pluralsight.com/player?course=building-linux-server-for-ruby-on-rails&author=jim-pickrell&name=building-linux-server-for-ruby-on-rails": [1, 13, 19, 13, 10, 7, 5, 5, 5, 1], 
  "https://app.pluralsight.com/player?course=ruby-on-rails-integrating-payments&author=kristian-freeman&name=ruby-on-rails-integrating-payments": [3, 3, 3, 3, 6, 2]
}

# Configuration
puts intro
video_file_check(video_url_hash)
youtube_dl_check
python3_check
ruby_check

# Python file path
python_file_path = "/usr/local/bin/youtube-dl" 

# Download cookie
`curl -v -X POST --data "user[email]=#{email}" --data "user[password]=#{password}" https://app.pluralsight.com/id -c ~/code/cookies.txt`
cookies_path = "~/Downloads/cookies.txt"


# Given array with number of clips for each module, return array of urls
def url_array(array, base_url)
  url_array = []
  
  array.map.with_index do |clips, index|
    #Add module number to base_url
    url_partial = "#{base_url}-m#{index+1}"
    
    clips.times do |clip|
      #Add clip number to url_partial
      url = "#{url_partial}&clip=#{clip}&mode=live"
      #Append full url to url_array
      url_array << url
    end  
  end
  url_array
end

# Given a hash of base_urls and number of clips for each module,
# return array of urls for every pair in the hash
def merged_url_array(video_url_hash)
  merged_url_array = []
  begin
    video_url_hash.each do |key, value|
      merged_url_array += url_array(value, key)
    end
  rescue
    puts "Your .txt file was not in the proper format. It must be formatted as as a hash without the {} around it"
    `exit`
  end
  merged_url_array
end

# For every url, call a syscommand
merged_url_array(video_url_hash).each do |url|
  `python3 #{python_file_path} #{url} --cookies #{cookies_path}`
end

private

  intro = %q(
    ##Pluralscript.rb

  )

  def video_file_check(video_file_hash)
    output = `ls | grep .txt`.split("\n")
    if output.count < 1
      puts "Please make a .txt file. It can be any name, but only 1 .txt file must exist in the same directory as pluralscript.rb"
    elsif output.count > 1
      puts "Please make sure there is only one .txt file"
    else
      video_file_hash  = Hash[File.read(output)
    end
  end

  def youtube_dl_check
    output = `youtube-dl --version`.chomp
    if output.nil?
     `sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl`
     `sudo chmod a+rx /usr/local/bin/youtube-dl` 
    end
  end

  def python3_check(python_file_path)
    output = `python3 --version`
    if output.nil?
      puts 'Please install python 3, then run this script again'
      `exit`
    else
      output = File.file?(python_file_path)
      if output.nil?
        puts 'Your python file path is not the default. Enter your file path below. eg. ~/usr/local/bin/youtube-dl'
        python_file_path = gets
      end
    end
  end

  def ruby_check
    output = `ruby --version`
    if output.nil?
      puts "Please install ruby, then run this script again"
      `exit`
    end
  end
  




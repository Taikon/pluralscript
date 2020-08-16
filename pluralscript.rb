##Pluralscript.rb

##Instructions
# Dependencies: youtube-dl, python3, ruby
# Replace youtube-dl file path with your own at the bottom of the page
# Replace the vide_url_hash with a base_url and an array of clip numbers for each module. See example below 
# Login to Pluralsight and download your registrations cookie
# Run the script with `ruby pluralscript.rb`

# Python file path
python_file_path = "/usr/local/bin/youtube-dl" 

# Add the base_url for your video followed by the number of clips for each module
video_url_hash = {
  "https://app.pluralsight.com/player?course=building-linux-server-for-ruby-on-rails&author=jim-pickrell&name=building-linux-server-for-ruby-on-rails": [1, 13, 19, 13, 10, 7, 5, 5, 5, 1], 
  "https://app.pluralsight.com/player?course=ruby-on-rails-integrating-payments&author=kristian-freeman&name=ruby-on-rails-integrating-payments": [3, 3, 3, 3, 6, 2]
}

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
  video_url_hash.each do |key, value|
    merged_url_array += url_array(value, key)
  end
  merged_url_array
end

# For every url, call a syscommand
merged_url_array(video_url_hash).each do |url|
  `python3 #{python_file_path} #{url}`
end

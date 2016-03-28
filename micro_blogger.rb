require 'jumpstart_auth'
require 'bitly'

Bitly.use_api_version_3


class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing MicroBlogger"
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
  	if message.length <= 140
  		@client.update(message)
  	else
  		puts "Warning, message too long"
  	end
  end

  def dm(target, message)
  	puts "Trying to send #{target} this direct message:"
  	puts message
  	message = "d @#{target} #{message}"
  	tweet(message)
  end

  def shorten(original_url)
  	puts "Shortening this url: #{original_url}"
  	bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    return bitly.shorten(original_url).short_url
  end

  def everyones_last_tweet
  	friends = @client.friends.to_a
  	friends.map! {|id| @client.user(id).screen_name.downcase}
  	friends.sort!
  	friends.each do |friend|
  		name = @client.user(friend).screen_name
  		message = @client.user(friend).status.text
  		time = @client.user(friend).status.created_at
  		puts "#{name} said this on #{time.strftime("%A, %b %d")
}: #{message}" 
  	end
  end

  def turl(message)
  	
  end

  def followers_list
  	screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }  			
  end

  def spam_my_followers(message)
  	names = followers_list
  	names.each do |name|
  		dm(name, message)
  	end
  end

  def run
  	puts "Welcome to the JSL Twitter Client!"
  	command =""
  	while command != "q"
  		printf "enter command: "
  		input = gets.chomp
  		parts = input.split(" ")
  		command = parts[0]
  		case command
	  		when 'q' then puts "Goodbye!"
	  		when 't' then tweet(parts[1..-1].join(" "))
	  		when 's' then shorten(parts[1])
	  		when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
	  		when 'dm' 
	  			screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
	  			# puts screen_names
	  			if screen_names.include?(parts[1])
	  				dm(parts[1], parts[2..-1].join(" "))
	  			else
	  				puts "You can only dm people who follow you."
	  			end
	  		when 'spam'
	  			spam_my_followers(parts[1..-1].join(" "))
	  		when 'elt' then everyones_last_tweet
	  		else
	  			puts "Sorry, I don't know how how to #{command}"
	  		end
  	end
  end
end

blogger = MicroBlogger.new

blogger.run

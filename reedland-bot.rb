require 'rubygems'
require 'bundler/setup'

# Require as usual below
require 'discordrb'
require 'json'
require './lib/output'
require './lib/settings'
require './lib/commands'

puts("Reedland-bot by Reedphish Heavy Industries. All rights reserved, 2016.")

# Load settings and commands
begin
	settings = Reedland::Settings.new
	settings.load(Reedland::Settings::DEFAULT_SETTINGS_FILE)
	commands = Reedland::Commands.new
rescue Exception => e
	Reedland::Output::error(e)
	exit(1)
end

# Main
begin
	applicationid = settings.get("discord", "applicationid")
	token = settings.get("discord", "token")
	serverid = settings.get("discord", "serverid")
	channelid = settings.get("discord", "channelid")
	botname = settings.get("discord", "botname")
	
	bot = Discordrb::Bot.new(token: token, application_id: applicationid, name: botname)
	bot.pm do |event|
		if event.text == "list"
			event.respond(commands.list)
		elsif event.text.start_with?("cmd")
				commandline = event.text[3..-1].strip().split(" ")
				command = commandline[0]

				commandline.delete_at(0)

				begin
					event.respond(commands.run(command, commandline))
				rescue Exception => e
					event.respond("Error: #{e}")
				end
		elsif event.text.strip == "prune"
			# event.channel.prune(100)
#=begin
			begin
				puts(event.channel.id)
				messagehistory = JSON.parse(Discordrb::API.channel_log(token, event.channel.id, 100))

				messagehistory.each do |message|
					Discordrb::API.delete_message(token, channelid, message["id"])
				end
			rescue Discordrb::Errors::NoPermission => e
				event.respond(e)
			end
#=end
		else
			event.respond("I don't know if I can do that, Dave...")
		end
	end

	bot.run(:async)
	bot.send_message(channelid, 'Bot is now active!')
	bot.sync
rescue Exception => e
	Reedland::Output::error(e)
	exit(1)
end


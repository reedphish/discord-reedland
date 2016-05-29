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
	botid = settings.get("discord", "botid")
	
	bot = Discordrb::Bot.new(
			token: token, 
			application_id: applicationid, 
			name: botname,
			fancy_log: false
		)

	# System wide wall message
	bot.message(start_with: '!wall') do |event|
		message = event.content[5..-1].strip.upcase

		if message.length > 0
			server = Discordrb::Server.new(
					JSON.parse(Discordrb::API.server(token, serverid)),
					bot
				)

			server.online_users(include_idle: true, include_bots: false).each do | user |
				user.pm(message)
			end
  		end
	end

	# Prune channel messages
	bot.message(matches: "!prune") do |event|
		channeldata = JSON.parse(Discordrb::API.channel(token, event.channel.id))
		channel = Discordrb::Channel.new(channeldata, bot)
		channel.prune(100)
	end

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


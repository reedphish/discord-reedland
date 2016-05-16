require 'rubygems'
require 'bundler/setup'

# Require as usual below
require 'discordrb'
require './lib/output'
require './lib/settings'
require './lib/commands'

puts("Reedland-bot by Reedphish Heavy Industries. All rights reserved, 2016.")

# Load settings and commands
begin
	settings = Reedland::Settings.new
	settings.load(Reedland::Settings::DEFAULT_SETTINGS_FILE)
	commands = Reedland::Commands.new
	commands.load(Reedland::Commands::DEFAULT_COMMANDS_FILE)
rescue Exception => e
	Reedland::Output::error(e)#
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
			if event.text.start_with?("cmd")
				splits = event.text.strip.split(" ")
				cmd = splits[1]
				splits.delete_at(0)
				splits.delete_at(1)
				args = splits.join(" ")
		
				begin
					result = commands.run(cmd, args)
					event.respond(result)
				rescue Exception => e
					event.respond("I messed up: #{e}")
				end
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


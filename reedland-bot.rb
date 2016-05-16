require 'rubygems'
require 'bundler/setup'

# Require as usual below
require 'discordrb'
require './lib/output'
require './lib/settings'

puts("Reedland-bot by Reedphish Heavy Industries. All rights reserved, 2016.")

# Load settings
begin
	settings = Reedland::Settings.new
	settings.load(Reedland::Settings::DEFAULT_SETTINGS_FILE)
rescue Exception => e
	Reedland::Output::error('Unable to load settings')#
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
	bot.pm(with_text: "Hi!") do |event|
  		event.respond "Hi, #{event.user.name}!"
	end

	bot.run(:async)
	bot.send_message(channelid, 'Bot is now active!')
	bot.sync



rescue Exception => e
	Reedland::Output::error(e)
	exit(1)
end


require 'rubygems'
require 'json'
require './commands/whois'
require './commands/host'
require './commands/nmap'

module Reedland
	class Commands
		def run(command, argument)
			case command
			when "whois"
				return Reedland::Command::WHOIS.run(argument).to_s
			when "host"
				return Reedland::Command::Host.run(argument).to_s
			when "nmap"
				return Reedland::Command::NMAP.run(argument).to_s
			end
		end
	end
end
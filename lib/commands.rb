require 'rubygems'
require 'json'

module Reedland
	class Commands
		DEFAULT_COMMANDS_FILE = './commands.json'

		def initialize
			@commands = nil
		end

		def load(commandsfile)
			begin
				@commands = JSON.parse(
						File.open(commandsfile).read()
					)
			rescue Exception => e
				raise("Unable to load commands: #{e}")
			end
		end

		def list
			lines = []

			@commands.each do |key, obj|
				lines << "#{key} - #{obj['description']} | #{obj['argument']}"
			end

			return lines.join("\n")
		end

		def run(command, argument)
			begin
				cmd = @commands[command]
				return "#{cmd['command']} #{argument}"
			rescue Exception => e
				raise "Somwthing is wrong with the command. Check all inputs and try again"
			end
		end
	end
end
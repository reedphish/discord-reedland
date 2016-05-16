require 'rubygems'
require 'rainbow/ext/string'

module Reedland
	class Output
		def self.warning(message)
			self.output("[WARNING] #{message}", :orange)
		end

		def self.error(message)
			self.output("[ERROR] #{message}", :red)
		end

		def self.success(message)
			self.output("[OK] #{message}", :green)
		end

		def self.output(message, color)
			puts(message.to_s.color(color))
		end
	end
end
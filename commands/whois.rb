require 'rubygems'
require 'whois'

module Reedland
	module Command
		class WHOIS
			def self.run(address)
				client = Whois::Client.new(:timeout => 10)
				return client.lookup(address.join(" "))
			end
		end
	end
end
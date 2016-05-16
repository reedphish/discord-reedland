require 'rubygems'
require 'net/dns'

module Reedland
	module Command
		class Host
			def self.run(address)	
				regular = Net::DNS::Resolver.start address.join(" ")
				mx = Net::DNS::Resolver.new.search(address.join(" "), Net::DNS::MX)

				return "#{regular}\n#{mx}"
			end
		end
	end
end
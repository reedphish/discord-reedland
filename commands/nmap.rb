require 'rubygems'
require 'nmap/program'
require 'nmap/xml'

module Reedland
	module Command
		class NMAP
			def self.run(address)
				scanfile = "./nmap_scan-#{(0...50).map { ('a'..'z').to_a[rand(26)] }.join}.xml"

				Nmap::Program.scan(
						:syn_scan => false,
					 	:service_scan => true,
					 	:os_fingerprint => false,
					 	:verbose => false,
					  	:ports => [20,21,22,23,25,80,110,443,512,522,8080,1080],
						:targets => address.join(" "),
						:xml => scanfile
					)

				result = []

				Nmap::XML.new(scanfile) do |xml|
					xml.each_host do |host|
				    	host.each_port do |port|
				      		result << "#{port.number} #{port.protocol} #{port.state} #{port.service}"
				    	end
				  	end
				end

				File.delete(scanfile)

				return result.join("\n")
			end
		end
	end
end
require 'rubygems'
require 'json'

module Reedland
	class Settings
		DEFAULT_SETTINGS_FILE = './settings.json'

		def initialize
			@settings = nil
		end

		def load(settingsfile)
			begin
				@settings = JSON.parse(
						File.open(settingsfile).read()
					)
			rescue Exception => e
				raise("Unable to load settings: #{e}")
			end
		end

		def get(section, setting)
			begin
				@settings[section][setting]
			rescue Exception
				raise("Unable to retrieve setting, check settings!")
			end
		end
	end
end
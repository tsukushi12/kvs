#!/home/pi/.rbenv/versions/2.3.1/lib/ruby

#{key: :value}
require "digest/md5"

class Dir

	attr_getter :key, :path

	def initialize(key)
		@key = key
		@path = parse(@key)
	end

	def parse(key)
		path = Digest::MD5.hexdigest(key)
		path.insert(8, "/")
		path.insert(17, "/")
		path.insert(26, "/")
	end
end


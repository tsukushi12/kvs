require 'net/http'
require './config'
require 'json'

class Hash
	def save
		http = Net::HTTP.new(Config::KvsHost, Config::KvsPort)
		req = Net::HTTP::Post.new("/save_hash")
		req.set_form_data(self)
		res = http.request(req)
		result = res.body
	end

	def self.get(key, any = 1)
		req = Net::HTTP::Get.new("/get/#{key}/#{any}")		
		res = Net::HTTP.start(Config::KvsHost, Config::KvsPort){|http|
			http.request(req)
		}
		result = JSON.parse(res.body)
		result.map{|t| JSON.parse(t)}
	end
end

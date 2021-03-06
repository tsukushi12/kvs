require 'net/http'
require_relative './config'
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
		http = Net::HTTP.new(Config::KvsHost, Config::KvsPort)
		req = Net::HTTP::Get.new("/get/#{key}/#{any}")
		res = http.request(req).body

		return res if res[0..2] =="not"
		JSON.parse(res)

		rescue JSON::ParserError
			res
	end
end

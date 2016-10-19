#!/home/pi/.rbenv/versions/2.3.1/lib/ruby

#{key: :value}

require './myfile.rb'
require 'json'

module MyIO
	@now = Time.now.strftime("%s%L")
	@orders = [:create, :get, :delete, :destroy]

	class << self
		def create(hash)
			kv_parse(hash){|key, value|
				MyFile.open(key, "a+"){|f|	
					f.write(value.to_json + " " + @now)
				}
			}
		end

		def get(key, any = 1)
			MyFile.open(key){|f|
				f.readline[-any..-1]
			}
		end

		def delete(hash)
			p hash
		end

		def destroy(key)

		end
	private
		def kv_parse(hash)
			hash.each do |key, values|
				if values.class == Array
					values.each do |i|
						yield(key, i)
					end
				else
					yield(key, values)
				end
			end
		end
	end
end

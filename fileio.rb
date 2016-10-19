#!/home/pi/.rbenv/versions/2.3.1/lib/ruby

#{key: :value}

class FileIO < DirIO

	def initialize(key, value)
		@value = value
		super key
	end

	def cleate
		File.open(@path, "w"){|f|
			f.write(value)
		}
	end


	def delete
		
	end
end


require 'json'
require 'fileutils'
class File
	def self.conflict(fp1, fp2)
		f1 = File.open(fp1, "r"){|f| f.readlines}
		f2 = File.open(fp2, "r"){|f| f.readlines}
		f = f1 | f2
		f.sort{|a,b| Json.parse(a)["time"] <=> JSON.parse(b)["time"]}.join("\n")
	end
end






lfiles = Dir.chdir("./db/"){
	`find  . -name "*" -type f`.split("\n")
}
rfiles = Dir.chdir("./db2/"){
	`find  . -name "*" -type f`.split("\n")	
}


conflict_files = rfiles & lfiles
new_files = rfiles - lfiles

conflict_files.each{|f|
	lf = f.sub('./', './db/')
	rf = f.sub('./', './db2/')
	if File.size(lf) != File.size(rf)
		File.open(lf, "w"){|f|
			f.write File.conflict(lf, rf)
		}

	end
}
new_files{|f|
	lf = f.sub('./', './db/')
	rf = f.sub('./', './db2/')
	FileUtils(rf, lf)
}

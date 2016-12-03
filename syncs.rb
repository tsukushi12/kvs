require 'json'
require 'fileutils'
require 'pry'
require './config.rb'

class File
	def self.conflict(fp1, fp2)
		f1 = File.open(fp1, "r"){|f| f.readlines}
		f2 = File.open(fp2, "r"){|f| f.readlines}
		f = f1 | f2
		f.sort{|a,b| JSON.parse(a)["time"] <=> JSON.parse(b)["time"]}.join("")
	end
end


lfiles = Dir.chdir(Config::DBDir){
	`find  . -name "*" -type f`.split("\n")
}
rfiles = Dir.chdir(Config::SubDir){
	`find  . -name "*" -type f`.split("\n")	
}


conflict_files = rfiles & lfiles
new_files = rfiles - lfiles

conflict_files.each{|f|
	lf = f.sub('./', Config::DBDir)
	rf = f.sub('./', Config::SubDIr)
	if File.size(lf) != File.size(rf)
			result = File.conflict(lf, rf)
			File.open(lf, "w"){|f| f.write result}
	end
}
new_files.each{|f|
	lf = f.sub('./', Config::DBDir)
	rf = f.sub('./', Config::DubDir)
	FileUtils.cp(rf, lf)
}

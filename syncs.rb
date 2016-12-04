require 'json'
require 'fileutils'
require './config.rb'

class File
	def self.conflict(fp1, fp2)
		f1 = File.open(fp1, "r"){|f| f.readlines}
		f2 = File.open(fp2, "r"){|f| f.readlines}
		f = f1 | f2
		f.sort{|a,b| JSON.parse(a)["time"] <=> JSON.parse(b)["time"]}.join("")
	end
end

loop do
sleep(10)

rdir = Config::Master + ":" + Config::MasterDir
sdir = Config::Master + ":" + Config::MasterStatus
system("rsync -uvrz --inplace -e 'ssh -i #{Config::SSHKey}' #{rdir} ./db2/")

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
	rf = f.sub('./', Config::SubDir)
	if File.size(lf) != File.size(rf)
			result = File.conflict(lf, rf)
			File.open(lf, "w"){|f| f.write result}
	end
}
new_files.each{|f|
	lf = f.sub('./', Config::DBDir)
	rf = f.sub('./', Config::SubDir)
	FileUtils.mkdir_p(File.dirname(lf))
	FileUtils.cp(rf, lf)
}



hostname = `hostname`.chomp
file_size = `du -s ./db/`.split("\t")[0]
cpu_temp = `cat /sys/class/thermal/thermal_zone0/temp`.chomp
now = Time.now.to_i.to_s
File.open("./status/#{hostname}.log", "a"){|f|

        f.puts [now, cpu_temp, file_size].join(" ")

}


system("rsync -uvrz --inplace -e 'ssh -i #{Config::SSHKey}' ./db/ #{rdir}")
system("rsync -uvrz --inplace -e 'ssh -i #{Config::SSHKey}' ./status/ #{sdir}")
end

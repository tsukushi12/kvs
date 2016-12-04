hostname = `hostname`.chomp
file_size = `du -s ./db/`.split("\t")[0]
cpu_temp = `cat /sys/class/thermal/thermal_zone0/temp`.chomp
now = Time.now.to_i.to_s
File.open("./db/#{hostname}.log", "a"){|f|	

	f.puts [now, cpu_temp, file_size].join(" ")

}

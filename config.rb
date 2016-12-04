
module Config
  DBDir = './db/'
  SubDir = './db2/'
  KvsHost = "localhost"
  KvsPort = 5000
  Master = "ubuntu@52.69.204.205"
  MasterDir =    "/home/ubuntu/kvs/db/"
  MasterStatus = "/home/ubuntu/kvs/status/"
  SSHKey = File.expand_path("~/.ssh/kvs.pem")
end

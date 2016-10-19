#!/home/pi/.rbenv/versions/2.3.1/lib/ruby

#{key: :value}
require 'digest/md5'
require './config.rb'

class DirIO

  attr_reader :key, :path

  def initialize(key)
    @key = key
    @dirpath = parse(@key)
    @dirtipe = dir_get_or_create
  end

  def parse(key)
    path = Digest::MD5.hexdigest(key)
    path.insert(8, "/")
    path.insert(17, "/")
    path.insert(26, "/")

    Config::DBDir + path
  end

  def dir_get_or_create(path)
    if Dir.exists?(path)
      1
    else
      Dir.mkdir(path)
    end
  end
end


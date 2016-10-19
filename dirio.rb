#!/home/pi/.rbenv/versions/2.3.1/lib/ruby

#{key: :value}
require 'digest/md5'
require './config.rb'

class DirIO

  attr_reader :key, :path

  def initialize(key)
    @key = key
    @path = parse(@key)
  end

  def parse(key)
    path = Digest::MD5.hexdigest(key)
    path.insert(8, "/")
    path.insert(17, "/")
    path.insert(26, "/")

    Config::DBDir + path
  end
end


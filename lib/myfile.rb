#!/home/pi/.rbenv/versions/2.3.1/lib/ruby

#{key: :value}

require 'digest/md5'
require './config.rb'
require 'fileutils'
class MyFile < File

  attr_reader :key, :path

  def initialize(key, mode = "r")
    @key = key
    @filepath = parse(@key)
    mkdir(@filepath)

    super(@filepath, mode)
  end

  def open(key, mode = "r")
    @key = key
    @filepath = parse(@key)
    mkdir(@filepath)

    super(@filepath, mode){ yield }
  end

  def parse(key)
    path = Digest::MD5.hexdigest(key)
    path.insert(8, "/")
    path.insert(17, "/")
    path.insert(26, "/")

    Config::DBDir + path
  end


  def unlink(key)
    super parse(key)
  end

  private
  def mkdir(path)
    dir = File.dirname(path)
    unless Dir.exists?(dir)
      FileUtils.mkdir_p(dir)
    end
  end
end

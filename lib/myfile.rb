#!/home/pi/.rbenv/versions/2.3.1/lib/ruby

#{key: :value}

require 'digest/md5'
require_relative '../config.rb'
require 'fileutils'

  class MyFile < File

    attr_reader :key, :path

    def initialize(key, mode = "r")
      @key = key
      @filepath = MyFile.parse(@key)
      mkdir(@filepath)
#      touch(@filepath)

      super(@filepath, mode)
    end

    def self.unlink(key)
      super parse(key)
    end

    def self.parse(key)
      path = Digest::MD5.hexdigest(key)
      path.insert(8, "/")
      path.insert(17, "/")
      path.insert(26, "/")

      Config::DBDir + path
    end

    def self.exists?(key)
      path = parse(key)
      File.exists?(path)
    end

    private
    def mkdir(path)
      dir = File.dirname(path)
      unless Dir.exists?(dir)
        FileUtils.mkdir_p(dir)
      end
    end

    def touch(path)
        unless File.exists?(path)
          FileUtils.touch(path)
        end
    end
  end

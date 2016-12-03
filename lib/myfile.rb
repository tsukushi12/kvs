#!/home/pi/.rbenv/versions/2.3.1/lib/ruby

#{key: :value}

require 'digest/md5'
require_relative '../config.rb'
require 'fileutils'

  class MyFile < File

    attr_reader :key, :path

    def initialize(key, mode = "r")
      @key = key
      @filepath = MyFile.to_path(@key)
      mkdir(@filepath)

      super(@filepath, mode)
    end

    def self.unlink(key)
      super MyFile.parse(key)
    end

    def self.to_path(key)
      path = Digest::MD5.hexdigest(key)
      path.insert(8, "/")
      path.insert(17, "/")
      path.insert(26, "/")

      Config::DBDir + path
    end

    def self.exists?(key)
      path = MyFile.to_path(key)
      File.exists?(path)
    end

    private
    def mkdir(filepath)
      dir = File.dirname(filepath)
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

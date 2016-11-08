#!/home/pi/.rbenv/versions/2.3.1/lib/ruby

#{key: :value}

require 'digest/md5'
require_relative '../config.rb'
require 'fileutils'

  class MyFile < File

    attr_reader :key, :path

    def initialize(key, mode = "r")
      @key = key
      @dirpath = MyFile.to_dir(@key)
      mkdir(@dirpath)
      @filepath = new_filepath(@dirpath)
#      touch(@filepath)

      super(@filepath, mode)
    end

    def self.unlink(key)
      super MyFile.parse(key)
    end

    def self.to_dir(key)
      path = Digest::MD5.hexdigest(key)
      path.insert(8, "/")
      path.insert(17, "/")
      path.insert(26, "/")

      Config::DBDir + path
    end

    def new_filepath(dirpath)
      filepth = dirpath + "/"  Time.now.strftime("%s%L")
      loop do
        if MyFile.exists?(filepath)
          filepath.succ
        else
          filepath
        end
      end
    end
    def self.exists?(key)
      path = parse(key)
      File.exists?(path)
    end

    private
    def mkdir(dir)
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

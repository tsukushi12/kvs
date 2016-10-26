#!/home/pi/.rbenv/versions/2.3.1/lib/ruby

#{:key => [:value, :value, ...]}

require './myfile.rb'
require 'json'
require './io_module.rb'

class MyIO

	def initialize(key = nil, *value)
		@kvs = {}
		add(key, value) if key && !value.empty?
		raise ArgumentError, "wong number of argument (1 for 0 or 2..)" if key && value.empty?
	end

	def add(key, *value)
		@kvs[key] ||= []
		@kvs[key].concat(value)
	end

	def find(key)
		@kvs[key]
	end

	def all
		@kvs
	end

	def save
		IOModule.send(:create, @kvs)
	end
	class << self
		include IOModule
	end
end

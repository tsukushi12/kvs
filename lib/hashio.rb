
#require 'lib/io_module'

class Hash
  def save
    IOModule.send(:create, self)
  end
end

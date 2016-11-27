require 'json'
  module IOModule


    def create(hash)
      kv_parse(hash){|key, value|
        MyFile.open(key, "a+"){|f|
          f.puts({key => value}.to_json)
        }
      }
    end

    def get(key, any = 1)
      if exists?(key)
        f = MyFile.open(key){|f|
          f.readlines[-any..-1].join("\n")
        }
      else
        "not found such key"
      end
    end

    def exists?(key)
        MyFile.exists?(key)
    end

    def destroy(key)
      MyFile.unlink(key)
    end

    private
    def kv_parse(hash)
      hash.each do |key, values|
        if values.class == Array
          values.each do |i|
            yield(key, i)
          end
        else
          yield(key, values)
        end
      end
    end
  end

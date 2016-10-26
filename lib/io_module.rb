
module IOModule


  def create(hash)
    kv_parse(hash){|key, value|
      MyFile.open(key, "a+"){|f|
        f.write(value.to_json + " " + now + "\n")
      }
    }
  end

  def get(key, any = 1)
    MyFile.open(key){|f|
      f.readline[-any..-1]
    }
  end

  def destroy(key)
    MyFile.(key)
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
  def now
     Time.now.strftime("%s%L")
  end
end

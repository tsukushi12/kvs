require 'json'
require 'sinatra'
require 'net/http'

  autoload :MyIO,       './lib/myio'
  autoload :MyFile,     './lib/myfile'
  autoload :IOModule,   './lib/io_module'
  autoload :HashIO,     './lib/hashio'


  get '/user/form' do
    erb :u_form
  end

  post '/user/add' do
    uname = params["uform"]
    res = Net::HTTP.get URI.parse("http://52.69.204.205:3000/repo/#{uname}")
    res = JSON.parse(res)
    if res["url"] != nil
      Dir.chdir('../'){
        system "git clone #{res['url']}"
      }
    end
  end

  get '/form' do

    erb :form
  end

  post '/form/save' do
    if params[:key] || params[:value]
      MyIO.create({params[:key] => params[:value]})
      "successful"
    else
      "ArgumentError"
    end
  end

  get '/get/:key/:any' do
    num = params[:any] || 0

    result = MyIO.get(params[:key], num.to_i)
    result.to_json
  end

  post '/save_ary/:key' do
    params = json.parse(request.body.read)
    if params.is_a?
      MyIO.cleate({params[:key] => params})
      "successful"
    else
      'TypeError'
    end
  end

  post '/save_hash' do

    if params.kind_of?(Hash)
      MyIO.create(params)
      "successful"
    else
      'TypeError'
    end
  end

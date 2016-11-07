require 'json'
#require './mydb'
require 'sinatra'

  autoload :MyIO,       './lib/myio'
  autoload :MyFile,     './lib/myfile'
  autoload :IOModule,   './lib/io_module'
  autoload :HashIO,     './lib/hashio'




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

    MyIO.get(params[:key], num.to_i)
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
    params = json.parse(request.body.read)
    if params.kind_of?(Hash)
      MyIO.create(params)
    else
      'TypeError'
    end
  end

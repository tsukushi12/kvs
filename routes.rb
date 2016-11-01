require 'sinatra'
require 'json'
require './mydb'

module Mydb
  get '/form' do

    erb :form
  end

  get 'form/save'do

  end

  post '/get/:key/:any' do
    num = params[:any] || 0

    MyIO.get(params[:key], num)
  end

  post '/save_ary/:key' do
    params = json.parse(request.body.read)
    if params.is_a?
      MyIO.cleate({params[:key], params})
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
end

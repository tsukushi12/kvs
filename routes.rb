require 'sinatra'
require 'json'


get '/form' do

  erb :form
end



get '/test' do

#  params = json.parse(request.body.read)
  request.body.read
end

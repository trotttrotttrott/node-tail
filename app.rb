require 'sinatra/base'
require 'sinatra/json'

class App < Sinatra::Base
  helpers Sinatra::JSON

  get '/' do
    haml :index
  end

  get '/tail' do
    tail = File.open(params[:file], 'r')
    json :success => true, :tail => tail.read
  end
end

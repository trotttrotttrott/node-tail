require 'sinatra/base'

class App < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/tail/:file' do
    'heello'
  end
end
